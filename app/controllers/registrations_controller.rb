class RegistrationsController < ApplicationController

  def new
    @user = session[:incomplete_user] ? User.new(session[:incomplete_user][:user_hash]) : User.new
  end

  def create
    if @user = User.create(user_params)
      @user.authentications.create(session[:provider]) if session[:provider]
      reset_session
    else
      redirect_to register_path
    end
  end

  def activate
    if @user = load_from_activation_token(params[:id])
      @user.activate!
      redirect_to profile_path
    else
      not_authenticated
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
