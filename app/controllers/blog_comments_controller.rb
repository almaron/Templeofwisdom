class BlogCommentsController < ApplicationController

  before_action :get_post

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    @comment.author = current_user.name
    respond_to do |f|
      if @comment.save
        f.html {}
        f.json { render partial: "blog_comment", locals:{blog_comment: @comment} }
      end
    end
  end

  def edit
    @comment = @post.comments.find(params[:id])
  end

  def update
    @comment = @post.comments.find(params[:id])
    if @comment.update(comment_params)
      respond_to do |f|
        f.html {}
        f.json { render partial: "blog_comment", locals:{blog_comment: @comment} }
      end
    end
  end

  def destroy
    @post.comments.find(params[:id]).destroy
    render json:nil
  end

  private

  def comment_params
    params.require(:comment).permit(:blog_post_id,:comment)
  end

  def get_post
    @post = BlogPost.find(params[:blog_post_id])
  end

end
