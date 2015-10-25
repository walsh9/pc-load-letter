class SiteController < ApplicationController

  def index
    @sorting = params[:sort]
    case @sorting
    when "trending"
      @questions = Question.trending
    when "open"
      @questions = Question.open
    when "recent"
      @questions = Question.recently_active
    when "closed"
      @questions = Question.closed
    when "unanswered"
      @questions = Question.unanswered
    else
      @questions = Question.trending
    end
  end



end

