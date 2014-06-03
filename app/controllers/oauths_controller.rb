class OauthsController < ApplicationController

  def auth
    login_at params[:provider]
  end

  def callback
    provider = params[:provider]
    if logged_in?
      add_provider_to_user(provider)
      redirect_to profile_path
    else
      if @user = login_from(provider)
        redirect_to root_path, notice: t('messages.notice.sessions.create.success')
      else
        @user = new_from(provider)
        redirect_to register_path
      end
    end
  end

  def destroy
    @auth.destroy if @auth = current_user.authentications.find_by(provider:params[:provider])
    respond_to do |format|
      format.html { redirect_to profile_path }
      format.json { render json: params[:provider] }
    end
  end
end
