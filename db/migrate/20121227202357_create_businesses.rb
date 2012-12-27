class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :logo
      t.text :description
      t.integer :country_id
      t.string :legal_name
      t.boolean :featured
      t.integer :currency_id
      t.text :notes
      t.integer :billing_address_id
      t.integer :mailing_address_id
      t.string :state

      t.timestamps
    end
  end
end
