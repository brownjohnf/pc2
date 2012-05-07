class AddSystemToPages < ActiveRecord::Migration
  def change
    add_column :pages, :system, :boolean, :default => false
  end
end
