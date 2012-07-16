class ChangeSettingToTextOnSiteConfigs < ActiveRecord::Migration
  def up
    change_column :site_configs, :setting, :text
  end

  def down
    change_column :site_configs, :setting, :string
  end
end
