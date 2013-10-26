class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :friendship_maker_id, :null => false
      t.integer :friendship_recipient_id, :null => false

      t.timestamps
    end

    add_index :friendships, :friendship_maker_id
    add_index :friendships, :friendship_recipient_id
    #add_index :friendships, [:friendship_maker_id, :friendship_recipient_id], :unique => true
  end
end
