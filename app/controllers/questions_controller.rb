class QuestionsController < UserActionsController

  before_action :user_is_owner?, only: [:update]

  def select_best_answer
      question = Question.find(params[:id])
      puts 'before save'
      question.best_answer = Answer.find(params[:best_answer])
    if question.save
      puts 'after save'
      p question.best_answer
      redirect_to question_path(question)
    else
      redirect_to question_path(question)
    end
  end

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


  private

  def user_is_owner?
    unless Question.find(params[:id]).user == current_user
      # Redirect to page that has the login here
      redirect_to login_path
    end
  end

end
