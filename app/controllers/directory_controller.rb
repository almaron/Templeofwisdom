class DirectoryController < ApplicationController
  before_action :dir_type
  def index
    @list = directory.all
  end

  def show
    @item = directory.find_by_param(params[:id])
  end

  private

  def dir_type
    @dir_type = params[:type].downcase[3,90].to_sym if params[:type]
  end

  def directory
    params[:type].constantize
  end
end
