require 'spec_helper'

feature 'Browsing the website', :type => :feature do
  before(:example) do
    @question = FactoryGirl.create :question
  end
  describe "User visits a question page" do
    it "sees a question and its details" do
      visit question_path(@question)
      expect(page).to have_text @question.title
      expect(page).to have_text @question.content
    end
  end
end