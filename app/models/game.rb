class Game < ActiveRecord::Base

  validates :name, :password, :start_time, presence: true

end
