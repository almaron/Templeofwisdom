class PagesController < ApplicationController

  before_action :get_page, only: [:edit, :update, :destroy]
  before_action :require_login, except: :show

  def index
    @pages = Page.all
  end

  def show
    if params[:root]
      render :root
    else
      @page = Page.find_by(:page_alias => params[:url])
    end
  end

  def new
    @page = Page.new parent: (params[:parent] || nil)
  end

  def create
    @page = Page.new page_params
    if @page.save
      #TODO add proper notice
      redirect_to pages_path, :notice => "pages.create.success"
    else
      flash.now[:alert] = "pages.create.fail"
      render :edit
    end
  end

  def edit

  end

  def update
    if @page.update(page_params)
      redirect_to pages_path
    else
      render :edit
    end
  end

  def destroy
    @page.destroy
    render :js => "$('#page_line_#{@page.id}').remove();"
  end


  private

  def get_page
    @page = Page.find params[:page]
  end

  def page_params
    params.require(:page).permit(:head, :page_title, :page_alias, :content, :partial, :partial_params, :published, :hide_menu, :sorting, :meta_title, :meta_description, :meta_keywords, :ancestry, :parent)
  end
end
