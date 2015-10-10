class Redirects::JournalRedirectsController < ApplicationController

  def show
    redirect_to Redirects::JournalRedirect.new(params[:journal], params[:page]).redirect
  end
end
