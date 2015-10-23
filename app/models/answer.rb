class Answer < ActiveRecord::Base
  belongs_to :question, touch: true
  belongs_to :user

  validates :content, :user, :question, presence: true
end
