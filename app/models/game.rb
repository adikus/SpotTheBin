class Game < ActiveRecord::Base

  attr_accessor :center_x
  attr_accessor :center_y
  attr_accessor :radius
  attr_accessor :category

  validates :name, :password, presence: true #:start_time
  validates :center_x, :center_y, numericality: { only_integer: true }
  validates :radius, numericality: true
  has_many :nodes
  has_many :players
  has_many :connections, through: :nodes, source: :connections

end
