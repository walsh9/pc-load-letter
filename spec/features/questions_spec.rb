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

feature 'Searching for questions', :type => :feature do
  before(:example) do
    @q1 = FactoryGirl.create :question, 
      {title: "I need help with my keyboard",
       content: "The five key doesn't work in windows"}
    @q2 = FactoryGirl.create :question, 
      {title: "I need help with my monitor",
       content: "I can't see blue in windows"}
  end
  describe "User searches for question contents" do
    it "finds correct questions by content" do
      visit root_path
      fill_in 'q', with: 'windows'
      click_button 'search-button'
      expect(page).to have_text @q1.title
      expect(page).to have_text @q1.content
      expect(page).to have_text @q2.title
      expect(page).to have_text @q2.content
    end
    it "finds correct questions by title" do
      visit root_path
      fill_in 'q', with: 'keyboard'
      click_button 'search-button'
      expect(page).to have_text @q1.title
      expect(page).to have_text @q1.content
      expect(page).not_to have_text @q2.title
      expect(page).not_to have_text @q2.content
    end
    it "doesn't return non-matching results" do
      visit root_path
      fill_in 'q', with: 'linux'
      click_button 'search-button'
      expect(page).to have_text 'No results'
      expect(page).not_to have_text @q1.title
      expect(page).not_to have_text @q1.content
      expect(page).not_to have_text @q2.title
      expect(page).not_to have_text @q2.content
    end
  end
end