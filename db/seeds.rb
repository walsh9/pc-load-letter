# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def seed!
  # create users
  20.times do 
    User.create()
  end
  users = User.all

  # create questions
  20.times do
    Question.create(user: users.sample, title: random_title, content: random_question_content)
  end
  questions = Question.all

  # create 1 to 8 answers for each question
  questions.each do |question|
    (rand(1..8)).times do
      question.answers << Answer.create(user: users.sample, content: random_answer_content)
    end
  end

  unanswered_questions = Question.where('best_answer_id IS NULL')
  # mark best answer for half of the questions
  unanswered_questions.sample(unanswered_questions.count / 2).each do |question|
    question.best_answer = question.answers.sample
    question.save
  end
end

def random_title
  "How do I #{Faker::Hacker.verb} #{Faker::Hacker.abbreviation} with #{Faker::Hacker.abbreviation}?"
end

def random_question_content
  "I've tried everything! Even #{Faker::Hacker.ingverb} my #{Faker::Hacker.abbreviation} #{Faker::Hacker.noun}!"
end

def random_answer_content
  Faker::Hacker.say_something_smart
end

seed!

