class AddBusinessIdColumnToPlayToken < ActiveRecord::Migration
  def up
    add_column :play_tokens, :business_id, :integer
  end

  def down
    remove_column :play_tokens, :business_id
  end
end
