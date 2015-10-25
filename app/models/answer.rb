class Answer < ActiveRecord::Base
  belongs_to :question, touch: true
  belongs_to :user
  has_many :comments, as: :commentable

  validates :content, :user, :question, presence: true
end
