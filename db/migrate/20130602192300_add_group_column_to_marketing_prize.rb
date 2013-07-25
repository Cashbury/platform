class AddGroupColumnToMarketingPrize < ActiveRecord::Migration
  def change
    add_column :marketing_prizes, :group, :string
  end
end
