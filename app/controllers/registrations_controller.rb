class RegistrationsController < ApplicationController
  def new
    @user = session[:incomplete_user] ? User.new(session[:incomplete_user][:user_hash]) : User.new
  end

  def create
  end

  def activate
  end
end
