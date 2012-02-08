class AddCountryToStaff < ActiveRecord::Migration
  def change
    add_column :staff, :country, :string
  end
end
