class Game < ActiveRecord::Base

  validates :name, :password, :start_time, presence: true
  has_many :nodes
  has_many :players

end
