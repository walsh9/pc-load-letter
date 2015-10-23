class QuestionsController < ApplicationController

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = User.find(1) # switch to current_user when auth is set up
    if @question.save
       render 'show'
    else
      render 'new'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end

end
