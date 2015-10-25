class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true, foreign_key: true
      t.belongs_to :voteable, polymorphic: true

      t.timestamps null: false
    end
    add_index :votes, [:voteable_id, :voteable_type]
  end
end
