class AddNewAttributesToUserModel < ActiveRecord::Migration
  
  def up
    add_column :users, :date_of_birth, :date
    add_column :users, :phone_number, :string
    add_column :users, :is_male, :boolean
    add_column :users, :account_status, :string
  end

  def down
    remove_column :users, :date_of_birth
    remove_column :users, :phone_number
    remove_column :users, :is_male
    remove_column :users, :account_status
  end

end
