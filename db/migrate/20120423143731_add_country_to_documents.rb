class AddCountryToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :country, :string
  end
end
