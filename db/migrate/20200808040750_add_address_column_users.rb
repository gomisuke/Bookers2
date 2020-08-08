class AddAddressColumnUsers < ActiveRecord::Migration[5.2]
  def up
  	add_column :users, :address, :string
  	remove_column :users, :address_city
  	remove_column :users, :address_street
  	remove_column :users, :prefecture_code
  end

  def down
  	remove_column :users, :address
  	add_column :users, :address_city, :string
  	add_column :users, :address_street, :string
  	add_column :users, :prefecture_code, :string
  end

end
