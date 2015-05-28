class RoleAppsController < ApplicationController

  before_action :require_login
  before_action :master_access, only: :show
  before_action :get_app, only: [:update, :destroy]

  def index
    @role_apps = current_user.role_apps
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end

  def show
    @role = Role.build_from_app(params[:id])
    render 'roles/show'
  end

  def create
    respond_to do |format|
      if (@role_app = current_user.role_apps.create app_params)
        @role_app.create_post current_user
        format.html { redirect_to role_apps_path, notice: "Create success" }
        format.json { render partial: 'role_app', locals: {role_app:@role_app} }
      else
        format.html { redirect_to role_apps_path, alert: 'Create failed' }
        format.json { render json:{errors: @role_app.errors.full_messages }, status: 500 }
      end
    end
  end

  def update
    respond_to do |format|
      if @role_app.update app_params
        format.html { redirect_to role_apps_path, notice: "Create success" }
        format.json { render partial: 'role_app', locals: {role_app:@role_app} }
      else
        format.html { redirect_to role_apps_path, alert: 'Create failed' }
        format.json { render json:{errors: @role_app.errors.full_messages }, status: 500 }
      end
    end
  end

  def destroy
    @role_app.destroy
    @role_app.destroy_post
    respond_to do |format|
      format.html { redirect_to roles_path }
      format.json { render json: {success: true} }
    end
  end

  private

  def app_params
    params.require(:role_app).permit(:head, :paths, :char_id)
  end

  def get_app
    @role_app = RoleApp.find(params[:id])
  end
end
