class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :best_answer, class_name: "Answer"
  has_many :answers

  validates :title, :content, :user, presence: true

  def rest_answers
    answers.order(:created_at).where.not(id: best_answer_id).includes(:user)
  end
end
