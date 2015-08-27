class UsersController < ApplicationController

  before_action :admin_access, except: [:show, :index]
  before_action :get_user, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html { }
      format.json {
        @users = case params[:scope]
                   when 'short'
                     User.active.where("id != ?", current_user.id)
                   when 'destroyed'
                     User.destroyed
                   else
                     User.includes(:char_delegations, :profile).present
        end
      }
    end

  end

  def show
    @chars = @user.own_chars.active.where(open_player: 1)
  end

  def edit
  end

  def update
    respond_to do |f|
      if @user.update(user_params)
        f.html { redirect_to users_path, notice: t("messages.notice.users.update.success")}
        f.json { render partial: "user", locals: {user: @user} }
      else
        f.html { render :edit }
        f.json { render nothing: true }
      end
    end
  end

  def destroy
    if @user.pending?
      @user.destroy
    else
      @user.update(activation_state: 'destroyed', email: 'destroyed')
    end
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
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :group, cancans: User::CANCANS, profile_attributes:[:full_name, :birth_date, :icq, :skype, :contacts, :viewcontacts])
  end
end
