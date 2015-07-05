class QuestionsController < ApplicationController
  before_action :require_login
  before_action :get_question, except: [:index, :create, :show]

  def index
    q = MasterQuestion.includes(:user)
    if params[:mine]
      q = q.where user_id: current_user.id
    elsif params[:filter]
      q = q.where status_id: MasterQuestion::STATUSES.index(params[:filter])
    else
      q
    end
    @questions = q.paginate page: params[:page], per_page: 15
  end

  def show
    @question = MasterQuestion.eager_load(:user).find params[:id]
  end

  def create
    @question = current_user.questions.create question_params
    if @question
      redirect_to question_path(@question), notice: t('messages.notice.questions.create.success')
    else
      redirect_to questions_path, alert: t('messages.alert.questions.create.failure')
    end
  end

  def edit
  end

  def update
    @question.update question_params
    respond_to do |format|
      format.html { redirect_to question_path(@question), notice: t('messages.notice.questions.update.success') }
      format.json { render json: { url: question_path(@question) } }
    end
  end

  def destroy
    @question.destroy if @question.user == current_user || current_user.is_in?([:admin, :master])
    redirect_to questions_path
  end

  private

  def get_question
    @question = MasterQuestion.find params[:id]
  end

  def question_params
    params.require(:master_question).permit(:status_id, :head, :text)
  end
end
