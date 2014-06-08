class ConfigsController < ApplicationController

  before_action :admin_access
  before_action :get_config, only: [:update, :destroy]

  def index
    respond_to do |format|
      format.html {}
      format.json {
        @configs = AdminConfig.all
        render json: @configs
      }
    end
  end

  def create
    @config = AdminConfig.create(config_params)
    respond_to do |format|
      format.html { redirect_to configs_path }
      format.json { render json: @config }
    end
  end

  def update
    @config.update(config_params)
    respond_to do |format|
      format.html { redirect_to configs_path }
      format.json { render json: @config}
    end
  end

  def destroy
    @config.destroy
    respond_to do |format|
      format.html { redirect_to configs_path }
      format.json { render :nothing => true }
    end
  end

  private

  def get_config
    @config = AdminConfig.find(params[:id])
  end

  def config_params
    params.require(:config).permit(:name, :value, :comment)
  end

end
