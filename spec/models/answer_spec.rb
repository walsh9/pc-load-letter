require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user) } 
  it { should validate_presence_of(:question) }
  it { should validate_presence_of(:question) }
  it { should validate_presence_of(:question) }
  it { should belong_to(:question) }
  it { should belong_to(:user) }
end
