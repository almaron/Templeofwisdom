class LogsController < ApplicationController
  before_action :get_log_types

  def index
    @logs = SysLog.paginate(page: params[:page], per_page: 20)
  end

  def show
    @logs = SysLog.where(log_type_id: params[:category]).paginate(page: params[:page], per_page: 20)
    render :index
  end

  private

  def get_log_types
    @log_types = LogType.all
  end
end
