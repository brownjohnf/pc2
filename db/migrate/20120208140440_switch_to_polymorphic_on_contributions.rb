class SwitchToPolymorphicOnContributions < ActiveRecord::Migration
  def change
    change_table :contributions do |t|
      t.references :contributable, :polymorphic => true
      t.remove :scope_id, :target_id, :comment
    end
  end
end
