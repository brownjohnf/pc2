class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :library_id
      t.string :title
      t.string :description
      t.integer :user_id
      t.string :attribution

      t.timestamps
    end
  end
end
