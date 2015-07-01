class AnswersController < ApplicationController
  before_action :require_login
  before_action :get_answer, except: [:create, :index]

  def index
    @answers = MasterAnswer.where(question_id: params[:question_id]).all
    respond_to do |format|
      format.json {}
    end
  end

  def show
    respond_to do |format|
      format.json {}
    end
  end

  def create
    update_question_status if (@answer = MasterAnswer.create answer_params.merge(user_id: current_user.id, question_id: params[:question_id]))
    respond_to do |format|
      format.html { redirect_to question_path(params[:question_id]) }
      format.json { render :show }
    end
  end

  def edit
    respond_to do |format|
      format.html {}
      format.json { render :show }
    end
  end

  def update
    @answer.update answer_params
    respond_to do |format|
      format.html { redirect_to question_path(@answer.question_id) }
      format.json { render :show }
    end
  end

  def destroy
    if @answer.user == current_user || current_user.is_in?([:admin, :master])
      @answer.destroy
      update_question_status
    end
    redirect_to question_path(params[:question_id])
  end

  private

  def update_question_status
    q = MasterQuestion.eager_load(:user).find params[:question_id]
    status = 2 if current_user.is_in? [:admin, :master]
    status = 4 if current_user == q.user
    status ||= 3
    q.update status_id: status
  end

  def get_answer
    @answer = MasterAnswer.includes(:user).find params[:id]
  end

  def answer_params
    params.require(:master_answer).permit(:text)
  end
end
