class AddTargetIdToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :target_id, :integer
  end
end
