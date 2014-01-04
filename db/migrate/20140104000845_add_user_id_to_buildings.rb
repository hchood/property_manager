class AddUserIdToBuildings < ActiveRecord::Migration
  def change
    add_column :buildings, :owner_id, :integer, null: false
  end
end
