class Redirects::TopicRedirectsController < ApplicationController
  def show
    redirect_to Redirects::TopicRedirect.new(params).redirect, status: 301
  end
end
