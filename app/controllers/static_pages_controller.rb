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
			generate_output(nil,nil,"F")
			return
		end

		time = Time.now.getutc
		if (time - game.start_time) > 0

			player = game.players.find_by(name: name)

			if (player.nil?)
				if ((time - game.start_time) < 5000000000)
					Player.create(name: name, password: pass, game_id: game.id)
					player=game.players.find_by(name: name)
					new_node = get_next_node(360,x,y,Node.where(game_id: game.id))
					if (new_node.nil?)
						@messages << "Player cannot join - Map is full."
						generate_output(player,game,"F")
						return
					end
					set_owner(player,new_node)
					@messages << "Player added."
					generate_output(player,game,"S")
					return
				else
					@messages << "It is too late to register."
					generate_output(player,game,"T")
					return
				end
			end

			if (player.password != pass)
				@messages << "Player did not log in with correct credentials."
				generate_output(nil,nil,"F")
				return
			end
			current = player.nodes.where(game: game).order(claimed_at: :desc).first
			possible = current.get_next_nodes
			tolerance = 30000
			next_node = get_next_node(tolerance,x,y,possible)
			if next_node.nil?
				@messages << "No node was in reach."
				generate_output(player,game,"O")
				return
			end
			set_owner(player,next_node)
			@messages << "Node taken."
			generate_output(player,game,"S")
			return
		else
			@messages << "Game has not started yet"
			generate_output(player,game,"T")
			return
		end
	end

	def generate_output (p, g, t)
		if t == "S"
			@o = "[[]]" + t + "[[]]"
			@o = @o + @messages.join(";;;") + "[\#\#\#]"
			@o = @o + "No errors [\#\#\#]"
			@o = @o + get_string_node_info(p,g) + "[\#\#\#]"
			@o = @o + get_string_node_circles(p,g) + "[\#\#\#]"
			@o = @o + get_string_connection_colors(p,g)
			@o = @o + "[[]]"
		else
			@o = "[[]]" + t + "[[]]" + @messages.join(";;;") + "[[]]"
		end

	end

	def get_string_connection_colors(p,g)
		cons = g.connections
		datas = []
		cons.each do |c|
			data = []
			if (c.node1.player_id == c.node2.player_id and (not c.node1.player_id.blank?))
				if c.node1.player_id == p.id
					color = 1
				else
					color = 2
				end
			else
				color = 0
			end
			data << c.node1.fx.to_s << c.node1.fy.to_s << c.node2.fx.to_s << c.node2.fy.to_s << color.to_s
			datas << data.join("[&&&]")
		end
		return datas.join("[;;;]")
	end

	def get_string_node_circles(p,g)
		players = g.players
		datas = []
		players.each do |player|
			data = []
			node = player.nodes.order(claimed_at: :desc).first
			if node.player_id == p.id
				color = 1
			else
				if node.player_id.blank?
					color = 0
				else
					color = 2
				end
			end
			data << node.fx.to_s << node.fy.to_s << color.to_s
			datas << data.join("[&&&]")
		end
		return datas.join("[;;;]")
	end

	def get_string_node_info(p,g)
		datas = []
		nodes = Node.where(game_id: g.id)
		nodes.each do |n|
			data = []
			if n.player_id == p.id
				color = 1
			else
				if n.player_id.blank?
					color = 0
				else
					color = 2
				end
			end
			data << n.fx.to_s << n.fy.to_s << color.to_s
			datas << data.join("[&&&]")
		end
		return datas.join("[;;;]")
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