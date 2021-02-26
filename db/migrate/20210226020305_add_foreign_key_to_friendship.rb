class AddForeignKeyToFriendship < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :friendships, :users, column: :receiver_id
    add_foreign_key :friendships, :users, column: :creator_id
  end
end
