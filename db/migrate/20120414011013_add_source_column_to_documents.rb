class AddSourceColumnToDocuments < ActiveRecord::Migration
  def self.up
    change_table :documents do |t|
      t.has_attached_file :source
      t.string :source_comment
      t.string :source_fingerprint
    end
  end

  def self.down
    drop_attached_file :documents, :source
    remove_column :documents, :source_comment
    remove_column :documents, :source_fingerprint
  end
end
