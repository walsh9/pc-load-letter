class AddCounterCacheColumns < ActiveRecord::Migration
  def change
    add_column :questions, :answers_count, :integer, index: true
    add_column :questions, :comments_count, :integer, index: true
    add_column :answers, :comments_count, :integer, index: true
  end
end
