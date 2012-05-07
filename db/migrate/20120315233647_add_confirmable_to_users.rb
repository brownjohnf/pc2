class AddConfirmableToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
    end
    add_index :users, :confirmation_token, :unique => true
  end

  def self.down
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_index :users, :confirmation_token
  end
end
