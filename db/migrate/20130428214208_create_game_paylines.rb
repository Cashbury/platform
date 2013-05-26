class CreateGamePaylines < ActiveRecord::Migration
  def change
    create_table :game_paylines do |t|
      t.integer :id
      t.integer :position
      t.string :group
      t.integer :icon1_id
      t.integer :icon2_id
      t.integer :icon3_id
      t.integer :game_id
      t.timestamps
    end

    add_column :game_paylines, :probability, :decimal, :precision => 15, :scale => 10

  end
end
