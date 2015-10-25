class QuestionsController < ApplicationController

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
       redirect_to question_path(@question)
    else
      @errors = @question.errors.full_messages
      render 'new'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end

end
