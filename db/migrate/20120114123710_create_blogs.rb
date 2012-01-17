class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :description
      t.string :url
      t.integer :user_id

      t.timestamps
    end
  end
end
