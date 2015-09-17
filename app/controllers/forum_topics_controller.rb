class ForumTopicsController < ApplicationController
  layout 'forum'

  before_action :require_login, except: [:show, :index]
  before_action :get_topic, except: [:new, :create, :index]
  before_action :master_access, only: :update, if: lambda{ params[:move].present? }
  before_action :master_access, only: :destroy

  def index
    @forum = Forum.find(params[:forum_id])
    #TODO change the clause for displaying hidden topics
    @all_topics = (current_user && current_user.is_in?(:admin)) ? @forum.topics : @forum.topics.shown
    per_page = params[:per_page] || 25
    @topics = @all_topics.paginate(page: params[:page], per_page: per_page) if @all_topics
    respond_to do |format|
      format.html {}
      format.json {}
    end
  end

  def show
    respond_to do |format|
      if @topic.is_available?(current_user) && topic_in_place
        @current_page = params[:post] && @topic.post_ids.include?(params[:post].to_i) ? ((@topic.post_ids.index(params[:post].to_i).to_f + 1)/ 15).ceil : nil
        format.html {
          if current_user
            @topic.forum_topic_reads.find_or_create_by(user_id: current_user.id)
          else
            @posts = @topic.posts.eager_load(:char, :avatar).paginate(page: @current_page || params[:page], per_page: 15)
            @path = @topic.forum.path
            render 'forum_topics/nouser/show'
          end
        }
        format.json {
          if current_user
            @draft = current_user.forum_post_drafts.find_by(topic_id: @topic.id)
            @chars = @topic.forum.technical > 0 ? current_user.chars.where('status_id IN (3,4,5)') : current_user.chars.where(status_id: 5)
          end
        }
      elsif !topic_in_place
        format.json { render json: { redirect: forum_topic_path(@topic.forum_id, @topic.id) }, status: 500 }
        format.html { redirect_to "#{forum_topic_path(@topic.forum_id, @topic.id)}?#{"page=#{params[:page]}&" if params[:page].present?}#{"post=#{params[:post]}" if params[:post].present?}" }
      else
        format.json { render json: {redirect: forum_path(@topic.forum_id), param_forum_id: params[:forum_id], topic_forum_id: @topic.forum_id}, status: 500}
        format.html {
          render template: 'application/error_404', status: 403
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
        draft = current_user.forum_topic_drafts.find_by(forum_id: params[:forum_id])
        if draft.nil?
          @topic = @forum.topics.new
          @post = @topic.posts.new
        else
          @topic = ForumTopic.new draft.to_topic
          @post = @topic.posts.new draft.to_post
        end
        @chars = @forum.technical? ? current_user.chars.where('status_id IN (3,4,5)') : current_user.chars.where(status_id: 5)
      }
    end
  end

  def create
    respond_to do |format|
      @topic = ForumTopic.new(topic_params)
      @post = @topic.posts.new post_params
      @topic.poster_name = @post.char.name
      @topic.char_id = @post.char_id
      if @topic.save
        ForumTopicDraft.find_by(user_id: current_user.id, forum_id: @topic.forum_id).try(:destroy)
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
      @topic.update update_params if @topic.is_editable?(current_user)
      format.html { redirect_to forum_topic_path(@topic.forum_id, @topic.id)}
      format.json { render :show }
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
    @topic = ForumTopic.eager_load(:forum).find_by(id:params[:id])
    unless @topic
      respond_to do |format|
        format.html { redirect_to forum_path(params[:forum_id]) }
        format.json { render json: {redirect: forum_path(params[:forum_id])} }
      end
    end
  end

  def topic_params
    params.require(:topic).permit(:head, :hidden, :closed, :poster_name).merge!(forum_id:params[:forum_id])
  end

  def update_params
    params.require(:topic).permit(:head, :hidden, :closed)
  end

  def post_params
    params.require(:post).permit(:char_id, :text, :avatar_id).merge!(user_id: current_user.id, ip: request.remote_ip)
  end

  def topic_in_place
    @topic.forum_id == params[:forum_id].to_i
  end

end
