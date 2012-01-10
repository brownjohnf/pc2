class AddStartToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :start, :integer
  end
end
