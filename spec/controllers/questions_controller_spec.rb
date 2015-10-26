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
    let(:user) { FactoryGirl.create :user }
    let(:question_params) { FactoryGirl.attributes_for(:question)}
    let(:invalid_question_params) { FactoryGirl.attributes_for(:question, content: nil)}
    it "creates a question with valid params" do
      stub_current_user(user)
      expect{post :create, :question => question_params}.to change(Question, :count).by(1)
    end
    it "doesn't create a question when params are invalid" do
      stub_current_user(user)
      expect{post :create, :question => invalid_question_params}.not_to change(Question, :count)
    end
  end

  describe "patch select_best_answer" do
    it "marks the answer as best answer" do
      answer = FactoryGirl.create(:answer)
      question = answer.question
      expect{ patch :select_best_answer, {'id' => question.id, 'best_answer' => answer.id} }.to change{ question.reload.best_answer }.from(nil).to(answer)
    end
    it "doesn't mark an invalid answer as best answer" do
      question = FactoryGirl.create(:question)
      invalid_answer = FactoryGirl.create(:answer)
      expect{ patch :select_best_answer, 'id' => question.id, 'best_answer' => invalid_answer.id }.not_to change{ question.reload.best_answer }
    end
  end

  describe "get search" do
    let(:user) { FactoryGirl.create :user }
    it "renders the template when logged out" do
      get :search, {'q' => "ruby"}
      expect(response).to render_template(:search)
    end
    it "renders the template when logged in" do
      stub_current_user(user)
      get :search, {'q' => "javascript"}
      expect(response).to render_template(:search)
    end
  end
end
