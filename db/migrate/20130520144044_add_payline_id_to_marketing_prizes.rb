class AddPaylineIdToMarketingPrizes < ActiveRecord::Migration
  
  def up
    add_column :marketing_prizes, :payline_id, :integer
  end

  def down
    remove_column :marketing_prizes, :payline_id
  end
end
