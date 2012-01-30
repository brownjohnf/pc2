class CreateSettings < ActiveRecord::Migration
  def change
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
