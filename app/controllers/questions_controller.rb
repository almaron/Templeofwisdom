class QuestionsController < ApplicationController
  before_action :require_login
  before_action :get_question, except: [:index, :create, :show]

  def index
    q = MasterQuestion.includes(:user)
    if params[:mine]
      q = q.where user_id: current_user.id
    elsif params[:filter]
      q = q.where status_id: MasterQuestion::STATUSES.index(params[:filter].to_sym)
    else
      q
    end
    @questions = q.paginate page: params[:page], per_page: 15
  end

  def show
    @question = MasterQuestion.eager_load(:user, answers: [:user]).find params[:id]
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
    redirect_to question_path(@question), notice: t('messages.notice.questions.update.success')
  end

  def destroy
    @question.destroy if @question.user == current_user || current_user.in?([:admin, :master])
    redirect_to questions_path
  end

  private

  def get_question
    @question = MasterQuestion.find params[:id]
  end

  def question_params
    params.require(:question).permit(:status_id, :head, :text)
  end
end
