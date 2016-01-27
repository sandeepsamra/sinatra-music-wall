class Song < ActiveRecord::Base
  
  belongs_to :user

  before_create :ensure_user

  private

  def ensure_user
    if user.username == nil
      return false
    else
      return true
    end
  end

end