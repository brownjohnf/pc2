class RemoveStartFromVolunteers < ActiveRecord::Migration
  def up
    remove_column :volunteers, :start
  end

  def down
    add_column :volunteers, :start, :integer
  end
end
