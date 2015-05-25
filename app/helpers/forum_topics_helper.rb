module ForumTopicsHelper
  def topic_init_params
    out = "{ forum_id: #{params[:forum_id]}, topic_id: #{params[:id]}"
    out += ", page: #{params[:page]}" if params[:page].present?
    out += ", post: #{params[:post]}" if params[:post].present?
    out += '}'
  end
end