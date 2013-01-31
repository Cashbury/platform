class CreateEventsTable < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.integer   :id
      t.datetime  :start
      t.datetime  :finish
      t.string    :name
      t.text      :dispatcher
      t.text      :receiver
      t.text      :payload
    end
  end

  def down
    drop_table :events
  end
end
