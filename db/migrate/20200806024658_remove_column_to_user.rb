class RemoveColumnToUser < ActiveRecord::Migration[5.2]
  def up
  	remove_column :users, :address_building
  end

  def down
  	add_column :users, :address_building, :string
  end
end
