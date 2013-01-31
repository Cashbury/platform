class AddCampaignsTable < ActiveRecord::Migration
  def up
    create_table :campaigns do |t|
      t.integer   :id
      t.string    :name
      t.integer   :campaign_type_id
      t.datetime  :start_date
      t.datetime  :end_time
      t.string    :state
    end
  end

  def down
  end
end
