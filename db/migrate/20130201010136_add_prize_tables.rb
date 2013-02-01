class AddPrizeTables < ActiveRecord::Migration
  def up
    create_table(:prize_items) do |t|
      t.integer :id
      t.string  :prize_name
      t.string  :description 
      t.string  :picture
      t.string  :redemption_method
      t.integer :quantity_available
      t.timestamps
    end

    add_column :prize_items, :value, :decimal, :precision => 8, :scale => 2, :default => 0.00
    add_column :prize_items, :cost,  :decimal, :precision => 8, :scale => 2, :default => 0.00

    create_table(:prize_marketing_money) do |t|
      t.integer :id
      t.string  :prize_name
      t.string  :description
      t.string  :picture
      t.string  :redemption_method
      t.integer :quantity_available
      t.timestamps
    end

    add_column :prize_marketing_money, :value, :decimal, :precision => 8, :scale => 2, :default => 0.00
    add_column :prize_marketing_money, :cost,  :decimal, :precision => 8, :scale => 2, :default => 0.00
  end

  def down
    drop_table :prize_items
    drop_table :prize_marketing_money
  end
end
