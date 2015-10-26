class VotesController < ApplicationController

  before_filter :load_voteable

  def create
    @vote = @voteable.votes.new
    @vote.user = current_user
    if @vote.save
      if @voteable.class == Answer
        redirect_to question_path(@voteable.question)
      else
        redirect_to question_path(@voteable.commentable)
      end
    else
      redirect_to question_path(@voteable.commentable) # fix to include error messaging
    end
  end

  private

  def load_voteable
    c = [Comment, Answer].detect { |k| params["#{k.name.underscore}_id"] }
    @voteable = c.find(params["#{c.name.underscore}_id"])
  end

end
