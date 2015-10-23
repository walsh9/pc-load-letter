require 'spec_helper'
require 'rails_helper'

describe AnswersController do

  describe "post create" do
    before(:all) { FactoryGirl.create(:question) }
    let(:user) { FactoryGirl.create :user }
    let(:answer_params) { FactoryGirl.attributes_for(:answer).merge!(question_id: Question.first.id) }
    let(:invalid_answer_params) { FactoryGirl.attributes_for(:answer, content: nil).merge!(question_id: Question.first.id) }
    it "creates an answer with valid params" do
      stub_current_user(user)
      expect{post :create, :answer => answer_params }.to change(Answer, :count).by(1)
    end
    it "doesn't create an answer when params are invalid" do
      stub_current_user(user)
      expect{post :create, :answer => invalid_answer_params}.not_to change(Answer, :count)
    end
  end

end