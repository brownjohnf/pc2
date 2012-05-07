class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.string :short
      t.integer :parent_id
      t.integer :type_id
      t.string :description

      t.timestamps
    end
  end
end
