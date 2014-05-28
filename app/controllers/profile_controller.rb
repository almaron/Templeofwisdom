class ProfileController < ApplicationController

  before_action :require_login
  before_action :get_user

  def show
    render "users/show"
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: "Update success"
    else
      redirect_to edit_profile_path, alert: "Update failed"
    end
  end

  private

  def get_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, profile_attributes: [:full_name, :birth_date, :icq, :skype, :contacts, :viewcontacts])
  end

end
