class CreateTableCampaignType < ActiveRecord::Migration
  def up
  	create_table :campaign_types do |t|
      t.integer   :id
      t.string    :name
      t.timestamps
    end
  end

  def down
  	drop_table :campaign_types
  end
end
