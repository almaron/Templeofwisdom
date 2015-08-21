class DelegationsController < ApplicationController

  before_action :require_login

  def create
    @delegation = CharDelegation.new delegation_params
    respond_to do |format|
      if @delegation.user && @delegation.char
        @delegation.save
        format.html { redirect_to profile_path }
        format.json { render partial: 'delegation', locals: {delegation: @delegation} }
      else
        format.html { redirect_to profile_path }
        format.json { render nothing: true }
      end

    end
  end

  def update
    current_user.default_char = params[:id]
    render json: { success: true }
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
