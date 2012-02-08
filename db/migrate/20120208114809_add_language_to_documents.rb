class AddLanguageToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :language_id, :integer
  end
end
