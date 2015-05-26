class AdminPagesController < ApplicationController

  before_action :admin_access
  before_action :set_page, except: [:index, :create, :save_tree]

  def index
    @pages = Page.roots if request.format.json?
  end

  def create
    @page = Page.create page_params
    render partial: 'page', locals: {page: @page}
  end

  def show
    render json: @page
  end

  def edit

  end

  def update
    respond_to do |format|
      if @page.update page_params
        format.json { render json: @page }
        format.js   { @message = :success}
      else
        format.json { render json: @page }
        format.js   { @message = :error  }
      end
    end
  end

  def save_tree
    tree_array = params[:tree]
    tree_array.each { |item| Page.find(item[:id]).update(item.permit(:sort_order, :parent_id)) }
    respond_to do |format|
      format.json {render json:{success:true} }
    end
  end

  def destroy
    @page.deplete!
    render json:'ok', status: :ok
  end

  private

  def set_page
    @page = Page.find_by id: params[:id]
    render json: {} unless @page
  end

  def page_params
    params.require(:page).permit(
      :head, :page_title, :page_alias,
      :content, :parent_id, :partial,
      :partial_params, :published,
      :hide_menu, :sort_order,
      :meta_title, :meta_description, :meta_keywords,
      :ancestry, :parent
    )
  end

end
