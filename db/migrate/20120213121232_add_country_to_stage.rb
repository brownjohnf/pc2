class AddCountryToStage < ActiveRecord::Migration
  def change
    add_column :stages, :country, :string

  end
end
