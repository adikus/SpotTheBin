class Node < ActiveRecord::Base

	belongs_to :game
	belongs_to :player
	belongs_to :place
  has_many   :connections, foreign_key: :node_id1

  def self.create_in_radius_of game
    nodes = []
    Place.in_radius_of(game).each{ |p| nodes << Node.create(place_id: p.id, game_id: game.id)}
    Connection.create_edges(nodes)
  end

  def fx
    place.fx
  end

  def fy
    place.fy
  end

end
