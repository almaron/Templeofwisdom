class ProfilesController < ApplicationController

  before_action :require_login

  def show
     respond_to do |format|
       format.html {}
       format.json { @user = User.includes(:profile, char_delegations: [{char: :char_delegations}]).find(current_user.id) }
     end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to profile_path, notice: "Update success" }
        format.json { render json: nil }
      else
        format.html { redirect_to edit_profile_path, alert: "Update failed" }
        format.json { render json: {errors: @user.errors.full_messages} }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, profile_attributes: [:full_name, :birth_date, :icq, :skype, :contacts, :viewcontacts])
  end

end
