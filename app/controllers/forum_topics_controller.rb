class ForumTopicsController < ApplicationController

  layout "forum"

  before_action :require_login, except: [:show, :index]
  before_action :get_topic, except: [:new, :create, :index]
  before_action :master_access, only: :update, if: lambda{ params[:move].present }
  before_action :master_access, only: :destroy

  def index
    @forum = Forum.find(params[:forum_id])
    #TODO change the clause for displaying hidden topics
    @all_topics = (current_user.is_in? :admin) ? @forum.topics : @forum.topics.shown
    per_page = params[:per_page] || 10
    @topics = @all_topics.paginate(page: params[:page], per_page: per_page) if @all_topics
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end
  
  def show
    respond_to do |format|
      if @topic.is_available?(current_user) && topic_in_place
        format.html { }
        format.json {
          @chars = @topic.forum.technical > 0 ? current_user.chars.where('status_id IN (3,4,5)') : current_user.chars.where('status_id = 5')
        }
      else
        format.json { render json: {redirect: forum_topic_path(@topic.forum_id, @topic.id), param_forum_id: params[:forum_id], topic_forum_id: @topic.forum_id}, status: 500}
        format.html {
          redirect_to forum_topic_path(@topic.forum_id, @topic.id)
        }
      end
    end
  end

  def new
    @forum = Forum.find(params[:forum_id])
    #TODO add the validations for hidden forums and playable chars
    respond_to do |format|
      format.html {}
      format.json {
        @topic = @forum.topics.new
        @post = @topic.posts.new
        @chars = @forum.technical > 0 ? current_user.chars.where("status_id IN (3,4,5)") : current_user.chars.where("status_id = 5")
      }
    end
  end

  def create
    respond_to do |format|
      @topic = ForumTopic.new(topic_params)
      @post = @topic.posts.new post_params
      @topic.poster_name = @post.char.name
      if @topic.save
        format.html { redirect_to forum_topic_path(params[:forum_id], @topic.id) }
        format.json { render json: {redirect: forum_topic_path(@topic.forum_id, @topic.id)} }
      else
        format.html { render :new }
        format.json { render json: {errors: [t("messages.errors.forum.topic_create")]}, status: 500 }
      end
    end
  end

  def edit
    @post = @topic.posts.first
    respond_to do |format|
      format.html { }
      format.json { }
    end
  end

  def update
    respond_to do |format|
      if params[:move] && current_user.is_in?(:admin, :master)
        @topic.update(forum_id:params[:move])
        format.html {}
        format.json { render json: {moved: true} }
      else
        if current_user.is_in? [:admin, :master] || @topic.char.delegated_to?(current_user)
          @topic.update topic_params
          @topic.posts.first.update post_params if params[:post]
        end
        format.html { redirect_to forum_topic_path(@topic.forum_id, @topic.id)}
        format.json { render :show }
      end
    end
  end

  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to @topic.forum }
      format.json { render :nothing => true }
    end
  end

  private

  def get_topic
    @topic = ForumTopic.find(params[:id])
    unless @topic
      respond_to do |format|
        format.html { redirect_to forum_path(params[:forum_id]) }
        format.json { render json: {redirect: forum_path(params[:forum_id])}, status: 500 }
      end
    end
  end

  def topic_params
    params.require(:topic).permit(:head, :hidden, :closed, :poster_name).merge!(forum_id:params[:forum_id])
  end

  def post_params
    params.require(:post).permit(:char_id, :text).merge!(user_id: current_user.id, ip: request.remote_ip)
  end

  def topic_in_place
    @topic.forum_id == params[:forum_id].to_i
  end

end