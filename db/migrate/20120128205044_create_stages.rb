class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :name
      t.date :arrival
      t.date :swear_in
      t.date :cos
      t.string :pc_id

      t.timestamps
    end
  end
end
