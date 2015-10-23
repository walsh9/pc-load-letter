class Answer < ActiveRecord::Base
  belongs_to :question, touch: true
  belongs_to :user
  has_many :comments, as: :commentable

  validates :content, :user, :question, presence: true

  def sorted_comments
    comments.order(:created_at).reverse
  end

  def has_comments?
    !comments.empty?
  end
end
