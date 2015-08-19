class JournalsController < ApplicationController

  def index
    @journals = Journal.published
  end

  def show
    @journal = Journal.includes(:pages).find(params[:id])
    @page = nil
    redirect_to journals_path, alert: t('messages.alert.journals.unpublished') unless @journal.published || (current_user && current_user.is_in?(:admin))
    respond_to do |f|
      f.html {
        render layout: 'journal'
      }
      f.json { }
    end
  end

  def page
    @page = JournalPage.includes(:images, :blocks, :tags, :journal).find(params[:page_id])
    @journal = @page.journal
    respond_to do |format|
      format.html { render :show, layout: 'journal' }
      format.json {}
    end
  end

end
