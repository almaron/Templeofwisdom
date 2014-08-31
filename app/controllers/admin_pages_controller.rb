class AdminPagesController < ApplicationController

  before_action :admin_access
  before_action :set_page, except: :index

  def index
    @pages = Page.all
  end

  def create
    @page = Page.create page_params
    render json: @page
  end

  def show
    render json: @page
  end

  def update
    @page.update page_params
    render json: @page
  end

  def destroy
    @page.deplete!
    render json:'ok', status: :ok
  end

  private

  def set_page
    @page = Page.find_by id: params[:page]
    render json: {} unless @page
  end

  def page_params
    params.require(:page).permit(:head, :page_title, :page_alias, :content, :partial, :partial_params, :published, :hide_menu, :sorting, :meta_title, :meta_description, :meta_keywords, :ancestry, :parent)
  end

end
