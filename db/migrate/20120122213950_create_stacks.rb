class CreateStacks < ActiveRecord::Migration
  def change
    create_table :stacks do |t|
      t.integer :library_id
      t.integer :user_id
      t.integer :scope_id
      t.integer :target_id
      t.string :comment

      t.timestamps
    end
  end
end
