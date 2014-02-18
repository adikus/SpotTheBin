class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :place_id
      t.integer :game_id
      t.integer :player_id
      t.timestamp :claimed_at

      t.timestamps
    end
  end
end
