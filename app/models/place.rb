class Place < ActiveRecord::Base
	has_many :nodes

  SCALE = 0.3775

  def self.in_radius_of(game)
    Place.all.select { |p| (game.radius*Place::SCALE*1000)**2 >= p.dist_sqr(game.center_x, game.center_y) }
  end

  def fy
    -42593.90208*y+2384150.649
  end

  def fx
    22520.79335*x+73792.44223
  end

  def dist_sqr(x,y)
    (fx-x)**2 + (fy-y)**2
  end
end
