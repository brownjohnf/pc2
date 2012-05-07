class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.integer :region_id
      t.text :description

      t.timestamps
    end
  end
end
