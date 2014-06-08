class ForumsController < ApplicationController

  def index
    respond_to do |format|
      format.html { }
      forma.json {
        @forums = Forum.roots
      }
    end
  end

  def show
    @forum = Forum.includes(:topics).find(params[:id])
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end

end
