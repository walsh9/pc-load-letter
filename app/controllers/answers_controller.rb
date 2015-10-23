class AnswersController < ApplicationController

  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to question_path("#{params[:answer][:question_id]}")
    else
      redirect_to question_path("#{params[:answer][:question_id]}") # change this redirect to include errors
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :question_id)
  end

end
