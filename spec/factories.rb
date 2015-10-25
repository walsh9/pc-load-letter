FactoryGirl.define do
  factory :user do
  end
end

FactoryGirl.define do
  factory :question do
    title "How do I #{Faker::Hacker.verb} #{Faker::Hacker.abbreviation} with #{Faker::Hacker.abbreviation}?"
    content "I've tried everything! Even #{Faker::Hacker.ingverb} my #{Faker::Hacker.abbreviation} #{Faker::Hacker.noun}!"
    association :user, factory: :user
  end
end

FactoryGirl.define do
  factory :answer do
    content Faker::Hacker.say_something_smart
    association :user, factory: :user
    association :question, factory: :question
  end
end

FactoryGirl.define do
  factory :question_comment, class: Comment do
    association :user, factory: :user
    content "Maybe you should look up #{Faker::Hacker.adjective} #{Faker::Hacker.noun}."
    association :commentable, factory: :question
  end
end

FactoryGirl.define do
  factory :answer_comment, class: Comment do
    association :user, factory: :user
    content "Maybe you should look up #{Faker::Hacker.adjective} #{Faker::Hacker.noun}."
    association :commentable, factory: :answer
  end
end