class AddCountryToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :country, :string
  end
end
