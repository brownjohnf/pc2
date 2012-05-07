class ChangeCountryOnMoments < ActiveRecord::Migration
  def up
    remove_column :moments, :country_id
    add_column :moments, :country, :string
  end

  def down
    remove_column :moments, :country
    add_column :moments, :country_id, :integer
  end
end
