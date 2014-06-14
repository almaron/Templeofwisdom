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
    @forum = Forum.find(params[:id])
    respond_to do |format|
      format.html {
        #TODO add proper redirection for hidden forums
      }
      format.json {

      }
    end
  end

end
