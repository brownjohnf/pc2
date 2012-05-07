class DropSettings < ActiveRecord::Migration
  def up
    drop_table :settings
  end
  
  def down
    create_table :settings do |t|
      t.string :property
      t.string :value
      t.string :explanation
      t.string :comment
      t.integer :user_id

      t.timestamps
    end
  end
end
