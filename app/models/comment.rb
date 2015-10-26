class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true, :counter_cache => true
  belongs_to :user
  has_many :votes, as: :voteable

  validates :content, :user, presence: true
end
