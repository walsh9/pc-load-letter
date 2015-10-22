class Question < ActiveRecord::Base
  belongs_to :user
  has_one :best_answer, class_name: "Answer"
  has_many :answers

  validates :title, :content, :user, presence: true
end
