class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :friend, index: true

      t.timestamps
    end

    add_foreign_key :friendships, :users, column: :friend_id
  end
end
