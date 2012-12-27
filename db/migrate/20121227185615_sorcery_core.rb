class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email,            :default => nil # if you use this field as a username, you might want to make it :null => false.
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
      t.string :first_name,       :default => nil
      t.string :last_name,        :default => nil
      t.string :activation_state
      t.string :activation_token
      t.string :activation_token_expires_at
      t.string :reset_password_token
      t.string :reset_password_token_expires_at
      t.string :reset_password_email_sent_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end