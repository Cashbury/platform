class AddSubdomainColumnToBusiness < ActiveRecord::Migration
  
  class Business < ActiveRecord::Base
    set_table_name 'businesses'
  end

  def up
    add_column :businesses, :subdomain, :string
    add_column :businesses, :master_pin, :string
    Business.all.each do |b|
      puts b.name
      b.subdomain = b.name.downcase.gsub(/\W/, '') || rand(100)
      b.save
    end
    change_column :businesses, :subdomain, :string, :null => false
  end

  def down
    remove_column :businesses, :subdomain
    remove_column :businesses, :master_pin
  end
end
