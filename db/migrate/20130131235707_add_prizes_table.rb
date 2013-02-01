class AddPrizesTable < ActiveRecord::Migration
  def up
    create_table :marketing_prizes do |t|
      t.integer   :id
      t.string    :name
      t.string    :prizeable_type
      t.string    :prizeable_id
      t.timestamps
    end
  end

  def down
    drop_table :marketing_prizes
  end
end
