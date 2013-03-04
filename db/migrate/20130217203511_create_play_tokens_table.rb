class CreatePlayTokensTable < ActiveRecord::Migration
  def up
    create_table :play_tokens do |t|
      t.integer :id
      t.string :state
      t.integer :user_id
      t.timestamps
    end
  end

  def down
    drop_table :play_tokens
  end
end
