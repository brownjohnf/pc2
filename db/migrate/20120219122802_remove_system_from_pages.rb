class RemoveSystemFromPages < ActiveRecord::Migration
  def up
    remove_column :pages, :system
      end

  def down
    add_column :pages, :system, :boolean
  end
end
