class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :short
      t.string :description
      t.integer :pcregion_id

      t.timestamps
    end
  end
end
