class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :best_answer, class_name: "Answer"
  has_many :answers

  validates :title, :content, :user, presence: true

  def sorted_answers_with_users
    answers.order(:created_at).includes(:user)
  end
end
