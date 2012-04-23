class AddCountryToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :country, :string
  end
end
