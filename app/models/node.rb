class Node < ActiveRecord::Base

	belongs_to :game
	belongs_to :player
	belongs_to :place

end
