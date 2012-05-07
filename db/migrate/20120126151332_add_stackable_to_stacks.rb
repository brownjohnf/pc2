class AddStackableToStacks < ActiveRecord::Migration
  def change
    change_table :stacks do |t|
      t.references :stackable, :polymorphic => true
      t.remove :scope_id, :target_id
    end
  end
end
