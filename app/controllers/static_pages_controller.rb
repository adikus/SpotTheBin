class StaticPagesController < ApplicationController
	def index
		@games = Game.all
	end

	def how_to_play

	end

	def what_is_spot_the_bin

	end

	def send_data
		@messages = []
		gname = params[:sgname]
		gpass = params[:sgpass]
		name = params[:sname]
		pass = params[:spass]
		x = params[:sx].to_f
		y = params[:sy].to_f
		game = Game.find_by(name: gname)
		if (game.nil? or (game.password != gpass))
			@messages << "Player did not log into the game with right credentials."
			return
		end

		time = Time.now.getutc
		if (time - game.start_time) > 0

			player = game.players.find_by(name: name)

			if (player.nil?)
				if ((time - game.start_time) < 12000)
					Player.create(name: name, password: pass, game_id: game.id)
					player=Player.find_by(name: name)
					new_node = get_next_node(360,x,y,Node.all)
					if (new_node.nil?)
						@messages << "Player cannot join - Map is full."
						return
					end
					set_owner(player,new_node)
					@messages << "Player added."
					return
				else
					@messages << "It is too late to register."
					return
				end
			end

			if (player.password != pass)
				@messages << "Player did not log in with correct credentials."
				return
			end

			current = player.nodes.where(game: game).order(claimed_at: :desc).first
			possible = current.get_next_nodes
			tolerance = 30000
			next_node = get_next_node(tolerance,x,y,possible)
			if next_node.nil?
				@messages << "No node was in reach."
				return
			end
			set_owner(player,next_node)
			@messages << "Node taken."
			return
		else
			@messages << "game has not started yet"
			return
		end
	end

	def get_next_node(tolerance,x,y,possible)
		min = tolerance
		our_node = nil
		dist = 0
		possible.each do |n|
			dist = Connection.pytagoras(x,y,n.place.x,n.place.y)
			if ((dist < tolerance) and (dist < min) and (n.player_id.blank?))
				our_node = n
				min = dist
			end
		end
		return our_node
	end

	def set_owner(player, node)
		node.update_attributes(player_id: player.id)
		node.update_attributes(claimed_at: node.updated_at)
	end
end