class SiteController < ApplicationController

  def index
    @questions = Question.all
  end

end
