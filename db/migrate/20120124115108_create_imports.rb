class CreateImports < ActiveRecord::Migration
  def self.up
    create_table :imports do |t|
      t.string  :name
      t.string  :comment
      t.integer :scope_id
      t.boolean :processed
      t.has_attached_file :csv

      t.timestamps
    end
  end

  def self.down
    drop_table :imports
  end
end
