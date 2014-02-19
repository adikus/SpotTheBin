class Game < ActiveRecord::Base

  attr_accessor :center_x
  attr_accessor :center_y
  attr_accessor :radius
  attr_accessor :category

<<<<<<< HEAD
  validates :name, :password, :start_time, presence: true
  validates :name, :uniqueness => {:message => "Well damn. That name is already taken."}
=======
  validates :name, :password, presence: true #:start_time
>>>>>>> b994d089dacb7e2de3281952f01472b61a871d26
  validates :center_x, :center_y, numericality: { only_integer: true }
  validates :radius, numericality: true
  has_many :nodes
  has_many :players
  has_many :connections, through: :nodes, source: :connections

end
