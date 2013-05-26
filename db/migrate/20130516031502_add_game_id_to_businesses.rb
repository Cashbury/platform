class AddGameIdToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :game_id, :integer
    add_foreign_key(:businesses, :games)
  end
end
