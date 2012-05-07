class DropPrivileges < ActiveRecord::Migration
  def up
    drop_table :privileges
  end

  def down
    create_table :privileges do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
