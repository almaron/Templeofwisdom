class IpsController < ApplicationController

  before_action :admin_access

  def index
    respond_to do |format|
      format.html {}
      format.json {
        @users = User.includes(:ips).all
        render json: @users.map {|user| {id: user.id, name:user.name, ips: user.ips.map(&:ip)}}
      }
    end
  end

end
