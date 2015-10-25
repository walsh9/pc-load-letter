class QuestionsController < ApplicationController

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @commentable = @question
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
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
