class AddContactInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email2, :string
    add_column :users, :phone1, :string
    add_column :users, :phone2, :string
  end
end
