class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.string :description
      t.string :attribution
      t.integer :library_id
      t.integer :user_id

      t.timestamps
    end
  end
end
