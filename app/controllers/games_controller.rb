class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      @nodes = Place.in_radius(@game)
      redirect_to root_url
    else
      render action: 'new'
    end
  end

  def game_params
    params.require(:game).permit(:name, :password, :start_time, :center_x, :center_y, :radius)
  end
end
