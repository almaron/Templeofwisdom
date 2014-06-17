class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token, if: lambda{request.format.json?}
  layout :set_layout

  def app_configs
    @config ||= FIXED_CONFIG.merge(AdminConfig.to_hash)
  end
  helper_method :app_configs

  def set_layout
    false if params[:no_layout]
  end

  def admin_access
    unless current_user && current_user.is_in?(:admin)
      redirect_to root_path, alert: t("messages.alert.general.error_403")
    end
  end

  def master_access
    unless current_user && current_user.is_in?([:admin, :master])
      redirect_to root_path, alert: t("messages.alert.general.error_403")
    end
  end

end
