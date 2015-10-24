class CommentsController < ApplicationController
  before_filter :load_commentable

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable
    else
      render :new
    end
  end

  private

  def load_commentable
    c = [Question, Answer].detect { |k| params["#{k.name.underscore}_id"] }
    @commentable = c.find(params["#{c.name.underscore}_id"])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
