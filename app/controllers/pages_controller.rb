class PagesController < ApplicationController

  before_action :get_page, only: [:edit, :update, :destroy]
  before_action :require_login, except: :show

  def show
    if params[:root]
      render :root
    else
      @page = Page.find_by(:page_alias => params[:url].split('/')[-1])
      unless @page && @page.published?
        render 'application/error_404'
      end
    end
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



end
