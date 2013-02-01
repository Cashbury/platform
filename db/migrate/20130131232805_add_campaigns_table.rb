class AddCampaignsTable < ActiveRecord::Migration
  def up
    create_table :marketing_campaigns do |t|
      t.integer   :id
      t.string    :name
      t.integer   :campaign_type_id
      t.integer   :business_id
      t.datetime  :start_date
      t.datetime  :end_time
      t.string    :state
      t.timestamps
    end
  end

  def down
    drop_table :marketing_campaigns
  end
end