class Node < ActiveRecord::Base

	belongs_to :game
	belongs_to :player
	belongs_to :place
  has_many :connections, foreign_key: :node_id1

  def self.create_in_radius_of game
    nodes = []
    Place.in_radius_of(game).each{ |p| nodes << Node.create(place_id: p.id, game_id: game.id)}
    Connection.create_edges(nodes)
  end

  def get_next_nodes
    connections = Connection.find_connections(self)
    next_nodes = []
    connections.each do |c|
      if c.node_id1 == self.id
        next_nodes << c.node2
      else
        next_nodes << c.node1
      end
    end
    return next_nodes
  end

  def fx
    place.fx.to_i
  end

  def fy
    place.fy.to_i
  end

end
