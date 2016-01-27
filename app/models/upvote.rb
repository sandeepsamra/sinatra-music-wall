class Upvotes < ActiveRecord::Base
  belongs_to :song, :user

  validates :user_id, uniqueness: {scope: :song_id}
end