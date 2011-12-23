class CreatePcregions < ActiveRecord::Migration
  def change
    create_table :pcregions do |t|
      t.string :name
      t.string :short
      t.string :description

      t.timestamps
    end
  end
end
