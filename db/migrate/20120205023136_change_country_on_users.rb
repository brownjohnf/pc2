class ChangeCountryOnUsers < ActiveRecord::Migration
  def up
    remove_column :users, :country_id
    add_column :users, :country, :string
  end

  def down
    remove_column :users, :country
    add_column :users, :country_id, :integer
  end
end
