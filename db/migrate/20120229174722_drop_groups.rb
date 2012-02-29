class DropGroups < ActiveRecord::Migration
  def up
    drop_table :groups
  end

  def down
    create_table :groups do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
