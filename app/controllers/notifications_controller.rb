class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.all
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end

  def show
    @notification = Notification.find params[:id]
    @notification.update(read:1)
    respond_to do |format|
      format.html { }
      format.json { render partial: 'note', locals: {note: @notification}}
    end
  end

  def destroy
    Notification.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to notifications_path }
      format.json { render json: {} }
    end
  end

end
