class AddLongNameToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :long_name, :string, :default => 'Please set a long_name on user roles.'
  end
end
