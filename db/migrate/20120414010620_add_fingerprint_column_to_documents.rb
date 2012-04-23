class AddFingerprintColumnToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :file_fingerprint, :string
  end
end
