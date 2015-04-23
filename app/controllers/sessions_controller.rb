class SessionsController < ApplicationController
  def new

  end

  def create
    if (@user = login(params[:user_login],params[:user_password], true))
      redirect_back_or_to root_path, notice: t("messages.notice.sessions.create.success")
    else
      redirect_to root_path, alert: t("messages.alert.sessions.create.failure")
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t("messages.notice.sessions.destroy.success")
  end

  def get_current_user
    current_user ? render(partial: "application/current_user", locals: {user: current_user}) : render(nothing:true)
  end
end
