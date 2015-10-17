class Redirects::ForumRedirectsController < ApplicationController

  def show
    redirect_to Redirects::ForumRedirect.redirect(params[:f].to_i), status: 301
  end

end
