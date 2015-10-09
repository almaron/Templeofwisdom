class PagesController < ApplicationController

  def show
    if params[:root]
      render :root
    else
      @page = Page.find_by(:page_alias => params[:url].split('/')[-1])
      unless @page && @page.published?
        render 'application/error_404', status: 404
      end
    end
  end


end
