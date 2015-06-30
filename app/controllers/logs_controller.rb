class LogsController < ApplicationController
  def index
    @logs = SysLog.paginate(page: params[:page], per_page: 20)
  end

  def show
    @logs = SysLog.where(log_type_id: params[:category]).paginate(page: params[:page], per_page: 20)
  end
end
