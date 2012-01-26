class AddPolyImagesToPhotos < ActiveRecord::Migration
  def change
    change_table :photos do |t|
      t.references :imageable, :polymorphic => true
    end
  end
end
