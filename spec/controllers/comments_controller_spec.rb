require 'rails_helper'
require 'spec_helper'

describe CommentsController do

  describe "post create" do
    let(:commentable_answer) { FactoryGirl.create(:answer) }
    let(:commentable_question) { FactoryGirl.create(:question) }
    let(:user) { FactoryGirl.create :user }
    let(:answer_comment_params) { FactoryGirl.attributes_for(:answer_comment) }
    let(:invalid_answer_comment_params) { FactoryGirl.attributes_for(:answer_comment, content: nil) }
    let(:question_comment_params) { FactoryGirl.attributes_for(:question_comment) }
    let(:invalid_question_comment_params) { FactoryGirl.attributes_for(:question_comment, content: nil) }

    it "creates an answer comment with valid params" do
      stub_current_user(user)
      expect{post :create, :answer_id => commentable_answer.id, :comment => answer_comment_params }.to change(Comment, :count).by(1)
    end

    it "doesn't create an answer comment when params are invalid" do
      stub_current_user(user)
      expect{post :create, :answer_id => commentable_answer.id, :comment => invalid_answer_comment_params}.not_to change(Comment, :count)
    end

    it "creates a question comment with valid params" do
      stub_current_user(user)
      expect{post :create, :question_id => commentable_question.id, :comment => question_comment_params }.to change(Comment, :count).by(1)
    end

    it "doesn't create a question comment when params are invalid" do
      stub_current_user(user)
      expect{post :create, :question_id => commentable_question.id, :comment => invalid_question_comment_params}.not_to change(Comment, :count)
    end
  end
end
