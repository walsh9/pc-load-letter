require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { FactoryGirl.create(:question) }
  let(:answer1) { FactoryGirl.create(:answer, question: question) }
  let(:answer2) { FactoryGirl.create(:answer, question: question) }
  describe "sorted_answers_with_users" do
    it "should return the answers in chronological order" do
      expect(question.sorted_answers_with_users).to eq([answer1, answer2])
    end
  end
end
