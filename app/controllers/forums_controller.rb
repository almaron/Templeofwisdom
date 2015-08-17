class ForumsController < ApplicationController

  layout "forum"

  def index
    respond_to do |format|
      format.html {
        unless current_user
          @forums = Forum.roots.visible
          render 'forums/nouser/index_nouser'
        end
      }
      format.json {
        @forums = Forum.roots.select{|f| f.is_visible?(current_user)}
      }
    end
  end

  def show
    @forum = Forum.find(params[:id])
    respond_to do |format|
      format.html {
        if current_user
          render template: 'application/error_404', status: :not_found unless @forum.is_visible?(current_user)
        else
          @topics = @forum.topics.paginate page: params[:page], per_page: 25
          if @forum.hidden?
            render template: 'application/error_404', status: :not_found
          else
            render 'forums/nouser/show_nouser'
          end
        end
      }
      format.json {

      }
    end
  end

  private

end
