require 'rails_helper'

RSpec.describe Question, type: :model do

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user) }
  it { should have_many(:answers) }
  it { should belong_to(:best_answer) }
  it { should belong_to(:user) }

  let(:question) { FactoryGirl.create(:question) }
  let(:answer1) { FactoryGirl.create(:answer, question: question) }
  let(:answer2) { FactoryGirl.create(:answer, question: question) }
  describe "rest_answers" do
    it "should return the answers in chronological order" do
      expect(question.rest_answers).to eq([answer1, answer2])
    end
    it "should not include the best answer" do
      question.best_answer = answer1
      question.save
      expect(question.rest_answers).to eq([answer2])
    end
  end
end

