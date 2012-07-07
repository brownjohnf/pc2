class CreateSiteConfigs < ActiveRecord::Migration
  def change
    create_table :site_configs do |t|
      t.string :name
      t.string :setting
      t.text :description

      t.timestamps
    end
  end
end
