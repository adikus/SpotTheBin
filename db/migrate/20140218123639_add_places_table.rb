class AddPlacesTable < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.float  :x
      t.float  :y
      t.string :category
    end
  end
end
