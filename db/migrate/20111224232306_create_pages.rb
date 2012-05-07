class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.string :title
      t.string :description
      t.text :content

      t.timestamps
    end
  end
end
