class JournalTagsController < ApplicationController
  def index
    @tags = JournalTag.order(:name).tokens(params[:q])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
  end
end
