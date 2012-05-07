class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.integer :user_id
      t.integer :scope_id
      t.integer :target_id
      t.string :comment

      t.timestamps
    end
  end
end
