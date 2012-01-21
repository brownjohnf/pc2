class AddPhotoToPages < ActiveRecord::Migration
  def change
    add_column :pages, :photo_id, :integer
  end
end
