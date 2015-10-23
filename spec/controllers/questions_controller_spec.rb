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
    before(:all) {FactoryGirl.create(:user)}
    let(:question_params) { FactoryGirl.attributes_for(:question)}
    let(:invalid_question_params) { FactoryGirl.attributes_for(:question, content: nil)}
    it "creates a question with valid params" do
      expect{post :create, :question => question_params}.to change(Question, :count).by(1)
    end
    it "doesn't create a question when params are invalid" do
      expect{post :create, :question => invalid_question_params}.not_to change(Question, :count)
    end
  end

end
