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
  	x = params[:sx]
  	y = params[:sy]

  	game = Game.find_by(name: gname)
  	if game.nil? or (game.password != gpass)
  		return
  	end
  	player = game.players.find_by(name: name)
  	
  	if player.nil? or (player.password != pass)
  		return
  	end

  	current = player.nodes.where(game: game).order(claimed_at: :desc).first
  	possible = current.connections


  end
end

