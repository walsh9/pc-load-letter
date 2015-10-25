class User < ActiveRecord::Base
  has_many :answers
  has_many :questions
  has_many :comments


  def to_param
    [id, name.parameterize].join("-")
  end
end
