class DropCountries < ActiveRecord::Migration
  def up
    drop_table :countries
  end

  def down
    create_table :countries do |t|
      t.string :name
      t.string :short
      t.string :description
      t.integer :pcregion_id

      t.timestamps
    end
  end
  
end
