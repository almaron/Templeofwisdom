class ResetPasswordsController < ApplicationController

  def create
    @user = User.find_by(email: params[:email])
    @user.deliver_reset_password_instructions! if @user
  end

  def edit
    @token = params[:token]
    @user = User.load_from_reset_password_token(params[:token])

    if @user.blank?
      not_authenticated
      return
    end
  end

  def update
    @token = params[:token]
    @user = User.load_from_reset_password_token(params[:token])

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password!(params[:user][:password])
      auto_login(@user)
      redirect_to profile_path, notice: I18n.t('messages.notice.reset_password.success')
    else
      render :action => "edit", alert: I18n.t('messages.alert.reset_password.failure')
    end
  end

end
