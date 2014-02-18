class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :node_id1
      t.integer :node_id2

      t.timestamps
    end
  end
end
