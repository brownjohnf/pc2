class DropMemberships < ActiveRecord::Migration
  def up
    drop_table :memberships
  end

  def down
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end
