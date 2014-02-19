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
        if (c.node2.player_id.blank?)
          next_nodes << c.node2
        end
      else
        if (c.node1.player_id.blank?)
          next_nodes << c.node1
        end
      end
    end
    return next_nodes
  end

  def fx
    place.fx
  end

  def fy
    place.fy
  end

end
