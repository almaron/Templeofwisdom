class UsersController < ApplicationController

  before_action :admin_access, except: [:show]
  before_action :get_user, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html { @users = User.includes(:char_delegations).all }
      format.json { @users = User.all }
    end

  end

  def show
  end

  def edit
  end

  def update
    respond_to do |f|
      if @user.update(user_params)
        f.html { redirect_to users_path, notice: t("messages.notice.users.update.success")}
        f.json { render :show }
      else
        f.html { render :edit }
        f.json { render nothing: true }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |f|
      f.html { redirect_to users_path, notice: t("messages.notice.users.destroy.success") }
      f.json { render nothing:true }
    end
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :group, profile_attributes:[:full_name, :birth_date, :icq, :skype, :contacts, :viewcontacts])
  end
end
