class JournalTagsController < ApplicationController
  def index
    @tags = JournalTag.order(:name).tokens(params[:q])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @tag = JournalTag.find_by(name: params[:tag]) || JournalTag.find(params[:tag])
    unless @tag
      redirect_to journals_path, alert: t('messages.alert.journal_tags.not_found')
      return
    end

    respond_to do |format|
      format.html { render layout: 'journal' }
      format.json {
        render json: { page_ids: @tag.page_ids, name: @tag.name, pages: [], current_page: -1 }
      }
    end
  end

end
