class ForumsController < ApplicationController

  layout "forum"

  def index
    respond_to do |format|
      format.html { }
      format.json {
        @forums = Forum.roots
      }
    end
  end

  def show
    respond_to do |format|
      format.html {}
      format.json {
        @forum = Forum.find(params[:id])
      }
    end
  end

end
