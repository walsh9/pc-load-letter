class AddPictureToUsers < ActiveRecord::Migration
  def change
    add_column :users, :picture, :string, default: "http://www.gravatar.com/avatar/?s=60&d=identicon"
  end
end
