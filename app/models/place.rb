class Place < ActiveRecord::Base
	has_many :nodes

  SCALE = 0.3775

  def self.in_radius_of(game)
    Place.all.select { |p| (game.radius*Place::SCALE*1000)**2 >= p.dist_sqr(game.center_x, game.center_y) }
  end

  def fx
    y*(10**5)*0.0049 + x*(10**5)*0.0791
  end

  def fy
    -y*(10**5)*0.0568 - x*(10**5)*1.0022
  end

  def dist_sqr(x,y)
    (fx-x)**2 + (fy-y)**2
  end
end
