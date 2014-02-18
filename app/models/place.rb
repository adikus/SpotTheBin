class Place < ActiveRecord::Base
	has_many :nodes

  SCALE = 0.3775

  def self.in_radius(game)
    Place.all.select { |p| (game.radius*Place::SCALE)**2 >= p.dist_sqr(game.center_x, game.center_y) }
  end

  def fx
    x*(10**4)*2.2721 + (10**4)*7.4448
  end

  def fy
    -y*(10**6)*0.043 + (10**6)*2.4078
  end

  def dist_sqr(x,y)
    (fx-x)**2 + (fy-y)**2
  end
end
