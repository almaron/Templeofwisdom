class BlogPostsController < ApplicationController

  before_action :get_post, only: [:edit, :update, :destroy]

  def index
    respond_to do |f|
      f.html { }
      f.json {
        nt = params[:limit] || app_configs[:news_per_page] || 5
        if params[:get_total]
          total = (BlogPost.count.to_f / nt).ceil
          render json:{total:total} if params[:get_total]
        else
          @posts = BlogPost.includes(comments: [:user]).paginate(:page => params[:page], :per_page => nt)
        end

      }
    end
  end

  def show
    @post = BlogPost.includes(:comments).find(params[:id]) if request.format.json?
    respond_to do |f|
      f.html {}
      f.json {render partial: "blog_post", locals: {blog_post:@post}}
    end
  end

  def new
  end

  def create
    respond_to do |f|
      if (@post = BlogPost.create(post_params))
        f.html {}
        f.json { render partial: "blog_post", locals: {blog_post:@post} }
      end
    end
  end

  def edit
    respond_to do |f|
      f.html {}
      f.json { render partial: "blog_post", locals: {blog_post:@post} }
    end
  end

  def update
    respond_to do |f|
      if @post.update(post_params)
        f.html {}
        f.json { render partial: "blog_post", locals: {blog_post:@post} }
      end
    end
  end

  def destroy
    @post.destroy
    render json:nil
  end

  private

  def get_post
    @post = BlogPost.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:author, :head, :text)
  end

end
