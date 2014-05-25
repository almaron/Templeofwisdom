class OauthsController < ApplicationController

  def auth
    login_at params[:provider]
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_to root_path, notice: t('messages.notice.sessions.create.success')
    else
      @user = new_from(provider)
      redirect_to register_path
    end
  end

  def destroy
    @auth.destroy if @auth = current_user.authentications.find(params[:id])
  end
end
