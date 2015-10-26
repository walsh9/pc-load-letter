namespace :counters do
  desc "reset database counter caches"
  task reset: :environment do
    Question.find_each { |question| Question.reset_counters(question.id, :comments, :answers) }
    Answer.find_each { |answer| Answer.reset_counters(answer.id, :comments) }
  end

end
