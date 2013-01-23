class SeperateOutLocationFields < ActiveRecord::Migration
  def up
    rename_column :locations, :address, :street_address
    add_column    :locations, :city, :string
    add_column    :locations, :state, :string
    add_column    :locations, :country, :string
    add_column    :locations, :postal_code, :string

    execute "UPDATE locations SET city = '1'"
    execute "UPDATE locations SET state = '1'"
    execute "UPDATE locations SET country = '1'"
    execute "UPDATE locations SET postal_code = '1'"

    change_column :locations, :city, :string, null: false
    change_column :locations, :state, :string, null: false
    change_column :locations, :country, :string, null: false
    change_column :locations, :postal_code, :string, null: false
  end

  def down
    rename_column :locations, :street_address, :address
    remove_column :locations, :city
    remove_column :locations, :state
    remove_column :locations, :country
    remove_column :locations, :postal_code
  end
end
