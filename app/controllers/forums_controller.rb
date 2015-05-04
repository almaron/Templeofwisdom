class ForumsController < ApplicationController

  layout "forum"

  def index
    respond_to do |format|
      format.html { }
      format.json {
        @forums = Forum.roots.select{|f| f.is_visible?(current_user)}
      }
    end
  end

  def show
    @forum = Forum.find(params[:id])
    respond_to do |format|
      format.html {
        render template: 'application/error_404', status: :not_found unless @forum.is_visible?(current_user)
      }
      format.json {

      }
    end
  end

end
