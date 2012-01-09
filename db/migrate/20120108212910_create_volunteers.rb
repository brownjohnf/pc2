class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.integer :user_id
      t.integer :pc_id
      t.text :emphasis
      t.text :projects
      t.integer :stage_id
      t.integer :cos_date
      t.string :local_name
      t.integer :site_id
      t.integer :sector_id

      t.timestamps
    end
  end
end
