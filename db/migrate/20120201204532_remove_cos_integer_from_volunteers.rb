class RemoveCosIntegerFromVolunteers < ActiveRecord::Migration
  def change
    remove_column :volunteers, :cos_date
  end
end
