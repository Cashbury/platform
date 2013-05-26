class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.integer :country_id
      t.integer :max_national_prizes
      t.integer :max_merchant_prizes
      t.timestamps
    end
  end
end
