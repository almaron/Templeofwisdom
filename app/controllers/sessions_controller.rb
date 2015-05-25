class SessionsController < ApplicationController
  def show
    current_user ? render(partial: 'shared/current_user', locals: {user: current_user}) : render(nothing:true)
  end

  def new
  end

  def create
    if (@user = login(params[:user_login],params[:user_password], true))
      redirect_back_or_to profile_path, notice: t('messages.notice.sessions.create.success')
    else
      flash.now[:alert] = t('messages.alert.sessions.create.failure')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t('messages.notice.sessions.destroy.success')
  end


end
