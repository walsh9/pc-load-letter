class Question < ActiveRecord::Base
  include PgSearch
  
  belongs_to :user
  belongs_to :best_answer, class_name: "Answer"
  has_many :answers
  has_many :comments, as: :commentable

  validates :title, :content, :user, presence: true
  validates :best_answer, inclusion: { in: :answers, allow_nil: true, 
    message: "is not a valid answer" }

  multisearchable :against => [:title, :content]
  pg_search_scope :search, :against => {title: 'A', content: 'B'},
                  :using => {
                    :tsearch => {:dictionary => "english"}
                  }

  # ordered by 
  def self.open
    where('best_answer_id IS NULL').includes(:user, :best_answer).order(created_at: :desc)
  end

  # ordered by question create time
  def self.unanswered
    includes(:user, :best_answer).where(:answers => { :id => nil }).includes(:user).order(created_at: :desc)
  end

  # ordered by question and answer activity. just comments don't bump you back up
  def self.recently_active
    includes(:user, :best_answer).order(updated_at: :desc)
  end

  # ordered by time best answer was selected
  def self.closed
    joins("LEFT JOIN answers ON questions.best_answer_id = answers.id").where('best_answer_id IS NOT NULL').includes(:user, :best_answer).order("answers.updated_at DESC")
  end

  # ordered by number of answers in past 24 hours
  def self.trending
    Question.select("questions.*, count(answers.id) AS recent_answers_count").
    includes(:user, :best_answer).
    joins(:answers).
    where(:"answers.updated_at" => (Time.now - 24.hours)..Time.now).
    group("questions.id").
    order("recent_answers_count DESC, questions.updated_at DESC")
  end

  def comments_and_rest_answers
    (rest_answers + comments).sort_by(:created_at => :desc)
  end

  def rest_answers
    answers.order(:created_at).where.not(id: best_answer_id).includes(:user, :comments)
  end

  def solved?
    best_answer != nil
  end

  def to_param
    [id, title.parameterize].join("-")
  end
end
