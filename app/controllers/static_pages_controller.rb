class StaticPagesController < ApplicationController
	def index
		@games = Game.all
	end

	def how_to_play

	end

	def what_is_spot_the_bin

	end

	def send_data
		gname = params[:sgname]
		gpass = params[:sgpass]
		name = params[:sname]
		pass = params[:spass]
		x = params[:sx].to_f
		y = params[:sy].to_f

		game = Game.find_by(name: gname)
		if (game.nil? or (game.password != gpass))
			return
		end

		player = game.players.find_by(name: name)

		if (player.nil? or (player.password != pass))
			return
		end
		current = player.nodes.where(game: game).order(claimed_at: :desc).first
		possible = current.get_next_nodes
		tolerance = 3
		next_node = get_next_node(tolerance,x,y,possible)
		next_node.update_attributes(player_id: player.id)
		next_node.update_attributes(claimed_at: next_node.updated_at)
		error
	end

	def get_next_node(tolerance,x,y,possible)
		min = tolerance
		our_node = nil
		dist = 0
		possible.each do |n|
			dist = Connection.pytagoras(x,y,n.place.x,n.place.y)
			if ((dist < tolerance) and (dist < min))
				our_node = n
				min = dist
			end
		end
		return our_node
	end
end