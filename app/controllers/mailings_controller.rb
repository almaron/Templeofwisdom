class MailingsController < ApplicationController

  before_action :admin_access

  def index
    @mailings = MailingLetter.includes(:user).all
  end

  def show
    @mailing = MailingLetter.find params[:id]
  end

  def new
    @mailing = MailingLetter.new
  end

  def create
    @mailing = MailingLetter.new mail_params
    if @mailing.save
      redirect_to mailings_path
    else
      render :new
    end
  end

  def destroy
    MailingLetter.find(params[:id]).destroy
    redirect_to mailings_path
  end

  private

  def mail_params
    params.require(:mailing_letter).permit(:subject, :text).merge(user_id: current_user.id)
  end
end
