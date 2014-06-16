class ForumPostsController < ApplicationController

  before_action :require_login, except: [:index, :show]
  before_action :get_post, only: [:edit, :update, :destroy, :show]

  def index
    per_page = 15
    @posts = ForumPost.where(topic_id: params[:topic_id]).paginate(page:params[:page], per_page: per_page)
    respond_to do |format|
      format.json{}
    end
  end

  def show
    respond_to do |format|
     format.json{}
    end
  end

  def new
    @post = ForumPost.new(topic_id:params[:topic_id])
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end

  def create
    respond_to do |format|
      if @post = ForumPost.create(post_params)
        format.html { redirect_to_topic }
        format.json { render partial: "post", locals: {post:@post}}
      else
        format.html { redirect_to_topic }
        format.json { render json: {errors: @post.errors.full_messages}, status: 500 }
      end
    end
  end

  def edit
    respond_to do |fortmat|
      fortmat.html {}
      fortmat.json { render :create }
    end
  end

  def update
    @post.update(post_params) if post_editable(@post)
    respond_to do |format|
      format.html { redirect to  }
      format.json { render partial: "post", locals: {post:@post} }
    end
  end

  def destroy
    respond_to do |format|
      if post_deletable @post
        @post.destroy
        format.html { redirect_to_topic }
        format.json { render json: true }
      else
        format.json { render json: false }
      end
    end
  end

  def post_editable(post)
    current_user.is_in? [:admin, :master] || post.char.delegated_to?(current_user)
  end
  helper_method :post_editable

  def post_deletable(post)
    current_user.is_in? :admin || (post.id == post.topic.last_post_id && post_editable(post))
  end
  helper_method :post_deletable

  def post_commentable
    current_user.is_in? [:admin, :master]
  end
  helper_method :post_commentable

  private

  def post_params
    if !params[:post][:comment].nil? && current_user.is_in?([:admin, :master])
      p_params = params.require(:post).permit(:comment, :commenter)
      p_params[:commented_at] = params[:post][:comment].present? ? DateTime.now : nil
      p_params
    else
      params.require(:post).permit(:char_id,:text).merge!(topic_id:params[:topic_id], user_id: current_user.id, ip: request.remote_ip)
    end
  end

  def get_post
    @post = ForumPost.find(params[:id])
  end

  def redirect_to_topic
    redirect_to forum_topic_path(params[:forum_id], @post.topic_id)
  end



end
