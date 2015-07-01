class AnswersController < ApplicationController
  before_action :require_login
  before_action :get_answer, except: [:create]

  def create
    update_question_status if (@answer = MasterAnswer.create answer_params.merge(user_id: current_user.id, question_id: params[:question_id]))
    redirect_to question_path(params[:question_id])
  end

  def edit
  end

  def update
    @answer.update answer_params
    redirect_to question_path(@answer.question_id)
  end

  def destroy
    if @answer.user == current_user || current_user.in?([:admin, :master])
      @answer.destroy
      update_question_status
    end
  end

  private

  def update_question_status
   q = MasterQuestion.eager_load(:user).find params[:question_id]

  end

  def get_answer
    @answer = MasterAnswer.includes(:user).find params[:id]
  end

  def answer_params
    params.require(:master_answer).permit(:text)
  end
end
