class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :password
      t.timestamp :start_time

      t.timestamps
    end
  end
end
