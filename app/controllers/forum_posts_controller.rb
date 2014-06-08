class ForumPostsController < ApplicationController

  before_action :require_login
  before_action :get_post, only: [:edit, :update, :destroy]

  def new
    @post = ForumPost.new(topic_id:params[:topic_id])
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end

  def create
    @post = ForumPost.create(post_params)
    respond_to do |format|
      format.html { redirect_to_topic }
      format.json { }
    end
  end

  def edit
    respond_to do |fortmat|
      fortmat.html {}
      fortmat.json { render :create }
    end
  end

  def update
    @post.update(post_params)
    respond_to do |format|
      format.html { redirect to  }
      format.json { render :create }
    end
  end

  def destroy
    if @post == @post.topic.last_post && (current_user.is_in? [:admin, :master] || @post.char.delegated_to?(current_user))
      @post.destroy
      respond_to do |format|
        format.html { redirect_to_topic }
        format.json { render js: true }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:char_id,:text).merge!(topic_id:params[:topic_id], user_id: current_user.id, ip: request.remote_ip)
  end

  def get_post
    @post = ForumPost.find(params[:id])
  end

  def redirect_to_topic
    redirect_to forum_topic_path(params[:forum_id], @post.topic_id)
  end

end
