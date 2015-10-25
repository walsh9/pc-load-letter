class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :best_answer, class_name: "Answer"
  has_many :answers
  has_many :comments, as: :commentable

  validates :title, :content, :user, presence: true




  def self.open
    where('best_answer_id IS NULL').includes(:answers, :user).order(created_at: :desc)
  end

  def self.unanswered
    includes(:answers).where(:answers => { :id => nil }).includes(:user).order(created_at: :desc)
  end

  def self.recently_active
    includes(:answers, :user).order(updated_at: :desc)
  end

  # should sort by updated at of best answer e.g. closed time
  def self.closed
    where('best_answer_id IS NOT NULL').includes(:answers, :user).order(updated_at: :desc)
  end

  # getting answer count makes this n+1 right now.
  # need to figure out how to eager load the answers
  def self.trending
    Question.select("questions.id, questions.title, questions.content, questions.user_id, questions.updated_at, count(answers.id) AS answers_count").
    includes(:user).
    joins(:answers).
    where(:"answers.updated_at" => (Time.now - 90.hours)..Time.now).
    group("questions.id").
    order("answers_count DESC")
  end

  def comments_and_rest_answers
    (rest_answers + comments).sort_by(&:created_at).reverse
  end

  def rest_answers
    answers.order(:created_at).where.not(id: best_answer_id).includes(:user)
  end

  def solved?
    best_answer != nil
  end
end
