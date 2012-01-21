class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.integer :user_id
      t.integer :country_id
      t.integer :photo_id
      t.date :datapoint
      t.string :title
      t.text :summary
      t.text :content

      t.timestamps
    end
  end
end
