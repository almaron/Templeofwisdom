class AdminJournalsController < ApplicationController

  before_action :master_access
  before_action :get_journal, only: [:show, :update]

  def index
    respond_to do |f|
      f.html {}
      f.json {
        @journals = Journal.all
        render json: @journals, only: [:id, :head, :published]
      }
    end
  end

  def show

  end

  def create
    @journal = Journal.create journal_params
    render json: @journal, only: [:id, :head, :published]
  end

  def update
    @journal.update(journal_params)
    render :show
  end

  def destroy
    Journal.find(params[:id]).destroy
    render nothing: true
  end

  private

  def get_journal
    @journal = Journal.includes(:pages).find(params[:id])
  end

  def journal_params
    params.require(:journal).permit(:head, :description, :remote_cover_url, :cover, :published)
  end

end
