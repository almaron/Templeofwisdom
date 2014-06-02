class DelegationsController < ApplicationController

  before_action :require_login

  def create
    @delegation = CharDelegation.create delegation_params
    respond_to do |format|
      format.html { redirect_to profile_path }
      format.json { render partial: 'delegation', locals: {delegation: @delegation} }
    end
  end

  def destroy
    @delegation = CharDelegation.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to profile_path }
      format.json { render json: nil }
    end
  end

  private

  def delegation_params
    params.require(:char_delegation).permit(:user_id, :char_id, :ending)
  end

end
