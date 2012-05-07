class RemoveUserAndLibraryFromPhotos < ActiveRecord::Migration
  def up
    remove_column :photos, :user_id
    remove_column :photos, :library_id
  end

  def down
    add_column :photos, :library_id, :integer
    add_column :photos, :user_id, :integer
  end
end
