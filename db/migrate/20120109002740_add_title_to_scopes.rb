class AddTitleToScopes < ActiveRecord::Migration
  def change
    add_column :scopes, :title, :string
  end
end
