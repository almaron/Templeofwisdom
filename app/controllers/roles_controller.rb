class RolesController < ApplicationController

  before_action :master_access, :except => :show
  before_action :get_role, only: [:show, :edit, :update, :destroy]


  def index
    respond_to do |format|
      format.html { @role_apps = RoleApp.all }
      format.json { @roles = Role.includes(char_roles:[:char]).all }
    end
  end

  def show
    respond_to do |format|
      format.html {  @only_content = true }
      format.json {  }
    end
  end

  def new
    @role = Role.build_from_app(params[:role_app_id])
    respond_to do |format|
      format.html {}
      format.json {
        if params[:get_chars]
          @chars = Char.where(status_id: 5).where('group_id != ?', 1).order(name: :asc)
          render :new
        else
          render :show
        end
      }
    end
  end

  def create
    respond_to do |format|
      if (@role = Role.create(role_params))
        SystemPosts::RoleCheckPost.new(current_user, @role, params[:role]).create
        Loggers::Role.new(current_user).log head: @role.head, id: @role.id, create: true
        format.html { redirect_to roles_path }
        format.json { render json: {redirect: roles_path} }
      else
        format.html { render :new }
        format.json { render json: {errors: @role.errors.full_messages}, status: 500 }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end

  def update
    respond_to do |format|
      if @role.update(role_params)
        Loggers::Role.new(current_user).log head: @role.head, id: @role.id, create: false
        format.html { redirect_to roles_path }
        format.json { render json: {redirect: roles_path} }
      else
        format.html { render :edit }
        format.json { render json: {errors: @role.errors.full_messages}, status: 500 }
      end
    end
  end

  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_path }
      format.json { render json: {success:true} }
    end
  end


  private

  def get_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:head, :paths, :comment, :role_app_id, char_roles_attributes: [:id, :char_id, :comment, :logic_points, :style_points, :skill_points, :volume_points, :added_points, :_destroy, role_skills_attributes: [:id, :skill_id, :done, :_destroy]])
  end

end
