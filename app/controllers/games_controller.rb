class GamesController < ApplicationController
  def new
    @places = Place.all
    @game = Game.new
    @categories = Place.select('DISTINCT(CATEGORY)')
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      @nodes = Place.in_radius_of @game
      redirect_to root_url
    else
      @places = Place.all
      @categories = Place.select('DISTINCT(CATEGORY)')
      render action: 'new'
    end
  end

  def game_params
    params.require(:game).permit(:name, :password, :start_time, :center_x, :center_y, :radius, category: [])
  end
end
