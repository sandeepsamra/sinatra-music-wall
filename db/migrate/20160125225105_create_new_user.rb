class CreateNewUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
    end
    add_reference :songs, :user
  end
end
