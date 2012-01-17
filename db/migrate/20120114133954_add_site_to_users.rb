class AddSiteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :site, :string, :default => nil
  end
end
