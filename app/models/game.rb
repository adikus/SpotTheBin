class Game < ActiveRecord::Base

  attr_accessor :center_x
  attr_accessor :center_y
  attr_accessor :radius

  validates :name, :password, :start_time, presence: true
  validates :center_x, :center_y, :radius, numericality: { only_integer: true }
  has_many :nodes
  has_many :players

end
