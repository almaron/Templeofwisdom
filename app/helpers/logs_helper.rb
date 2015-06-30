module LogsHelper
  def current_category
    @log_types.find {|t| t.id == params[:category].to_i}
  end
end
