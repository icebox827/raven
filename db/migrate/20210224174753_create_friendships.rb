class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.int :user_id
      t.int :friend_id

      t.timestamps
    end
    add_index :friendships, :user_id
    add_index :friendships, :friend_id
  end
end
