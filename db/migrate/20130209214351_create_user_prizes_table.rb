class CreateUserPrizesTable < ActiveRecord::Migration
  def up
    create_table :user_prizes do |t|
      t.integer :id
      t.integer :user_id, :null => false
      t.integer :prize_id, :null => false
      t.string  :state, :default => 'unlocked'
      t.timestamps
    end
  end

  def down
    drop_table :user_prizes
  end
end
