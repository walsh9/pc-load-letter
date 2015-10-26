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
  let(:answer3) { FactoryGirl.create(:answer) }

  describe "validate best_answer" do
    it "should allow a valid best answer" do
      question.best_answer = answer2
      expect(question).to be_valid
    end
    it "should not allow an invalid best answer" do
      question.best_answer = answer3
      expect(question).not_to be_valid
    end
    it "should allow a nil best answer" do
      question.best_answer = nil
      expect(question).to be_valid
    end
  end
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

  describe "search" do
      let!(:question) do
        FactoryGirl.create(:question, 
          {title: "Why does my ruby program crash?",
           content: "here is the source 'while true; puts hello; end'."
          }) 
      end
      it "finds by title" do
        expect(Question.search("ruby").first).to eq(question)
      end
      it "finds by content" do
        expect(Question.search("source").first).to eq(question)
      end
      it "returns empty when it has no results" do
        expect(Question.search("java")).to be_empty
      end

  end
end

