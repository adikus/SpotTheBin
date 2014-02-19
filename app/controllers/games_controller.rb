class GamesController < ApplicationController

  def show
    @game = Game.find(params[:id])
  end

  def new
    @places = Place.all
    @game = Game.new
    @categories = Place.select('DISTINCT(category)')
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      @nodes = Node.create_in_radius_of @game
      redirect_to @game
    else
      @places = Place.all
      @categories = Place.select('DISTINCT(category)')
      render action: 'new'
    end
  end

  def game_params
    params.require(:game).permit(:name, :password, :start_time, :center_x, :center_y, :radius, category: [])
  end
end
