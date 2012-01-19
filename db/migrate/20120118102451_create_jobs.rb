class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :staff_id
      t.integer :position_id
      t.date :start
      t.date :end
      t.string :comment

      t.timestamps
    end
  end
end
