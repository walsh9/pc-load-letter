require 'rails_helper'
require 'spec_helper'

describe VotesController do

  describe "post create" do
    let(:voteable_answer) { FactoryGirl.create(:answer) }
    let(:commentable_question) { FactoryGirl.create(:question) }
    let(:voteable_comment) { FactoryGirl.create(:question_comment) }
    let(:user) { FactoryGirl.create :user }
    let(:answer_vote_params) { FactoryGirl.attributes_for(:answer_vote) }
    let(:question_comment_vote_params) { FactoryGirl.attributes_for(:question_comment_vote) }

    it "creates an answer vote" do
      stub_current_user(user)
      expect{post :create, :answer_id => voteable_answer.id, :vote => answer_vote_params }.to change(Vote, :count).by(1)
    end

    it "creates a comment vote with valid params" do
      stub_current_user(user)
      expect{post :create, :question_id => commentable_question.id, :comment_id => voteable_comment.id, :vote => question_comment_vote_params }.to change(Vote, :count).by(1)
    end

  end

end
