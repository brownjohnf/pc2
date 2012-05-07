class ChangeCountryOnRegions < ActiveRecord::Migration
  def up
    remove_column :regions, :country_id
    add_column :regions, :country, :string
  end

  def down
    remove_column :regions, :country
    add_column :regions, :country_id, :integer
  end
end
