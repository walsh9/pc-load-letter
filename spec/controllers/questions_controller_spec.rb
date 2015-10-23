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

end