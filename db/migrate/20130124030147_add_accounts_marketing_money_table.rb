class AddAccountsMarketingMoneyTable < ActiveRecord::Migration
  def up
    create_table :marketing_money_account do |t|
      t.integer :id
      t.integer :owner_id
      t.string  :state
      t.integer :business_id
    end

    add_column :marketing_money_account, :balance, :decimal, :precision => 8, :scale => 2, :default => 0.00
    add_column :marketing_money_account, :limit,   :decimal, :precision => 8, :scale => 2, :default => 1000.00
  end

  def down
    drop_table :marketing_money_account
  end
end
