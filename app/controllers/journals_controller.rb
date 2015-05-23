class JournalsController < ApplicationController

  def index
    @journals = Journal.published
  end

  def show
    respond_to do |f|
      f.html {
        render layout: 'journal'
      }
      f.json {
        @journal = Journal.includes(:pages).find(params[:id])
      }
    end
  end

  def page
    @page = JournalPage.includes(:images, :blocks, :tags, :journal).find(params[:page_id])
  end

end
