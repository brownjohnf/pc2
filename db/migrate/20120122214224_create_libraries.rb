class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :description
      t.integer :country_id
      t.integer :user_id

      t.timestamps
    end
  end
end
