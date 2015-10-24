require 'rails_helper'
require 'spec_helper'

RSpec.describe CommentsController, type: :controller do

  describe "post create" do
    before(:all) { FactoryGirl.create(:answer) }
    let(:user) { FactoryGirl.create :user }
    let(:answer_comment_params) { FactoryGirl.attributes_for(:answer_comment) }
    let(:invalid_answer_comment_params) { FactoryGirl.attributes_for(:answer_comment, content: nil) }
    it "creates a comment with valid params" do
      stub_current_user(user)
      expect{post :create, :comment => answer_comment_params }.to change(Comment, :count).by(1)
    end
    it "doesn't create an answer when params are invalid" do
      stub_current_user(user)
      expect{post :create, :comment => invalid_answer_comment_params}.not_to change(Comment, :count)
    end
  end
end
