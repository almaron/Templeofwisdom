class AdminForumsController < ApplicationController

  before_action :admin_access
  before_action :get_forum, except: [:index, :create, :save_tree]

  def index
    respond_to do |format|
      format.html {}
      format.json {
        @forums = Forum.roots
      }
    end
  end

  def save_tree
    tree_array = params[:tree]
    tree_array.each { |item| Forum.find(item[:id]).update(item.permit(:sort_order, :parent_id)) }
    respond_to do |format|
      format.json {render json:{success:true} }
    end
  end

  def show
    respond_to do |f|
      f.json {}
    end
  end

  def create
    @forum = Forum.create(forum_params)
    respond_to do |f|
      f.json { render partial: "forum", locals: {forum:@forum} }
    end
  end

  def update
    @forum.update(forum_params)
    respond_to do |f|
      f.json { render partial: "forum", locals: {forum:@forum} }
    end
  end

  def destroy
    @forum.destroy
    respond_to do |f|
      f.json { render json: true}
    end
  end

  private

  def get_forum
    @forum = Forum.find(params[:id])
  end

  def forum_params
    params.require(:forum).permit(:name, :parent_id, :ancestry, :remote_image_url, :description, :technical, :hidden, :is_category, :sort_order)
  end

end
