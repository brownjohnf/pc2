class AddCosDateToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :cos_date, :date
  end
end
