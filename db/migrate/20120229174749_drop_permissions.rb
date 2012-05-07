class DropPermissions < ActiveRecord::Migration
  def up
    drop_table :permissions
  end

  def down
    create_table :permissions do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :scope_id
      t.integer :privilege_id
      t.string :comment

      t.timestamps
    end
  end
end
