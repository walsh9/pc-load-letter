require 'spec_helper'
require 'rails_helper'

describe QuestionsController do
  describe "get show" do
    let(:question) {FactoryGirl.create(:question)}
    it "assigns the question" do
      get :show, {'id' => question.id}
      expect(assigns(:question)).to eq question
    end
    it "renders the show template" do
      get :show, {'id' => question.id}
      expect(response).to render_template("show")
    end

  end

  describe "post create" do
    let(:question) { FactoryGirl.build :question, :title => "Test Question", :content => "Do you know the answer?", :user => 1 }
    it "increases the count of all questions by 1" do
      question.save
      expect(question.save).to change { Question.count }.by(1)
    end
  end

end
