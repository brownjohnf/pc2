class AddCountryToPages < ActiveRecord::Migration
  def change
    add_column :pages, :country, :string
  end
end
