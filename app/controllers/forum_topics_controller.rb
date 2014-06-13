class ForumTopicsController < ApplicationController

  layout "forum"

  before_action :require_login, except: [:show, :index]
  before_action :get_topic, except: [:new, :create, :index]
  before_action :master_access, only: :update, if: lambda{ params[:move].present }
  before_action :master_access, only: :destroy

  def index
    @forum = Forum.find(params[:forum_id])
    #TODO change the clause for displaying hidden topics
    @all_topics = current_user.is_in? :admin ? @forum.topics.all : @forum.topics.shown
    @topics = @all_topics.paginate(page: params[:page], per_page: params[:per_page] || 10) if @all_topics
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end
  
  def show
    respond_to do |format|
      format.html {
        redirect_to forum_topic_path(@topic.forum_id, @topic.id) unless params[:forum_id] == @topic.forum_id
        #TODO add redirects when topic is hidden and user does not have valid permissions
      }
      format.json { }
    end
  end

  def new
    @topic = ForumTopic.new
    @post = @topic.posts.new
  end

  def create
    respond_to do |format|
      if @topic = ForumTopic.create(topic_params)
        @topic.create_first_post post_params
        format.html { redirect_to forum_topic_path(params[:forum_id], @topic.id) }
        format.json { render :show }
      else
        format.html { render :new }
        format.json { render json: {errors: @topic.errors.full_messages} }
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
      if params[:move]
        @topic.update(forum_id:params[:move])
        format.html {}
        format.json { render json: {moved: true} }
      else
        if current_user.is_in? [:admin, :master] || @topic.char.delegated_to?(current_user)
          @topic.update topic_params
          @topic.posts.first.update post_params
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
    redirect_to forum_path(params[:forum_id]) unless @topic
  end

  def topic_params
    params.require(:forum_topic).permit(:head, :hidden, :closed, :poster_name).merge!(forum_id:params[:forum_id])
  end

  def post_params
    params.require(:post).permit(:char_id, :text).merge!(user_id: current_user.id, ip: request.remote_ip)
  end

end