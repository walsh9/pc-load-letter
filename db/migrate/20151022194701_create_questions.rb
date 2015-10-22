class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :best_answer, index: true
      t.string :title, null: false
      t.text :content, null: false

      t.timestamps null: false
    end
  end
end
