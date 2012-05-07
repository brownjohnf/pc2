class AddFingerprintColumnToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :photo_fingerprint, :string
  end

  def self.down
    remove_column :photos, :photo_fingerprint
  end
end
