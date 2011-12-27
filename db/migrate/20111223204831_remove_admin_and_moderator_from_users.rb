class RemoveAdminAndModeratorFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :admin
    remove_column :users, :moderator
  end

  def down
    add_column :users, :moderator, :boolean
    add_column :users, :admin, :boolean
  end
end
