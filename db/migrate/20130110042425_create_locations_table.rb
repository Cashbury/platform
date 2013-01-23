class CreateLocationsTable < ActiveRecord::Migration
  def up
    create_table :locations do |t|
      t.integer :id
      t.references :business
      t.boolean :is_mobile
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :phone_number
      t.text :description
      t.string :featured_image
      t.timestamps
    end
  end

  def down
    drop_table :locations
  end
end
