class Game < ActiveRecord::Base

  attr_accessor :center_x
  attr_accessor :center_y
  attr_accessor :radius
  attr_accessor :category

  validates :name, :password, :start_time, presence: true
  validates :center_x, :center_y, numericality: { only_integer: true }
  validates :radius, numericality: true
  has_many :nodes
  has_many :players

end
