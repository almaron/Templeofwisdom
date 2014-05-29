class GuestPostsController < ApplicationController


  before_action :set_guest_post, only: [:edit, :update, :destroy]
  before_action :admin_access, only: [:edit, :update, :destroy]

  skip_before_action :verify_authenticity_token, if: lambda{request.xhr?}

  def index
    nt = params[:limit] || app_configs[:guest_posts_per_page] || 5
    @posts = GuestPost.paginate(:page => params[:page], :per_page => nt)
  end


  def new
    @guest_post = GuestPost.new
  end

  def edit
  end


  def create
    @guest_post = GuestPost.new(guest_post_params)
    @guest_post.ip = request.remote_ip
    respond_to do |format|
      if @guest_post.save
        format.html { redirect_to guest_posts_path, notice: 'Post created' }
        format.json {}
      else
        format.html { render action: 'new' }
        format.json { render nothing: true }
      end
    end
  end

  def update
    respond_to do |format|
      if @guest_post.update(guest_answer_params)
        format.html { redirect_to guest_posts_path, notice: 'Answer posted' }
        format.json { render :create }
      else
        format.html { render action: 'edit' }
        format.json { render json: @guest_post.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @guest_post.destroy
    respond_to do |f|
      f.html { redirect_to guest_posts_path }
      f.json { render nothing: true }
    end
  end

  private
    def set_guest_post
      @guest_post = GuestPost.find(params[:id])
    end


    def guest_post_params
      params.require(:guest_post).permit(:head, :content, :user, :captcha, :valid_captcha)
    end

    def guest_answer_params
      params.require(:guest_post).permit(:answer)
    end
end
