class Player < ActiveRecord::Base

	validates :name, :uniqueness => {scope: :game_id, :message => "Well damn. That name is already taken."}

	belongs_to :game
	has_many :nodes
end
