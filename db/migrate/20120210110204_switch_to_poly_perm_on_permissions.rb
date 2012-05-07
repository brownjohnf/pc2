class SwitchToPolyPermOnPermissions < ActiveRecord::Migration
  def change
    change_table :permissions do |t|
      t.references :permissable, :polymorphic => true
      t.remove :user_id, :scope_id, :target_id, :comment
    end
  end
end
