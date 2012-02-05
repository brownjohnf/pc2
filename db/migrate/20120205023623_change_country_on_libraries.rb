class ChangeCountryOnLibraries < ActiveRecord::Migration
  def up
    remove_column :libraries, :country_id
    add_column :libraries, :country, :string
  end

  def down
    remove_column :libraries, :country
    add_column :libraries, :country_id, :integer
  end
end
