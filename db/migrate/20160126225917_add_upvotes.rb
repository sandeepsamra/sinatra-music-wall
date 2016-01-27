class AddUpvotes < ActiveRecord::Migration
  def change
    create_join_table :songs, :users, table_name: :upvotes do |t|
      t.index :song_id
      t.index :user_id
      t.integer :vote
    end
  end
end