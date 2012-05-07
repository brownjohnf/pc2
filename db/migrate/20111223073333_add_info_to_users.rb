class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio, :string
    add_column :users, :country_id, :integer
    add_column :users, :name, :string
  end
end
