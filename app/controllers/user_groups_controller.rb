class UserGroupsController < ApplicationController
  
  def index 
    @groups = %w(user master admin)
    respond_to do |f|
      f.html { render :nothing => true}
      f.json {}
    end
  end
end
