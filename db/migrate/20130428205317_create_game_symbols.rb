class CreateGameSymbols < ActiveRecord::Migration
  def change
    create_table :game_icons do |t|
      t.integer :id
      t.string :public_name
      t.string :internal_name
      t.string :icon
      t.string :retina_icon
      t.integer :game_id
      t.timestamps
    end
  end
end
