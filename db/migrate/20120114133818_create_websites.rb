class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string :name
      t.string :description
      t.string :url
      t.integer :language_id

      t.timestamps
    end
  end
end
