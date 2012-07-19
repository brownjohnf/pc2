class AddFieldsToSiteConfigs < ActiveRecord::Migration
  def change
    add_column :site_configs, :true, :boolean, :default => false

    add_column :site_configs, :category, :string

    add_column :site_configs, :title, :string

    add_index :site_configs, :name, :unique => true
  end
end
