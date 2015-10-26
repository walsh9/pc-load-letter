class Answer < ActiveRecord::Base
  belongs_to :question, touch: true
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :votes, as: :voteable

  validates :content, :user, :question, presence: true

  def sorted_comments
    comments.order(:created_at).reverse
  end

  def has_comments?
    !comments.empty?
  end

  def to_your_question?(user)
    question.user == user
  end
end
