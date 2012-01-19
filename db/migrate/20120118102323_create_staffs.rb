class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.integer :user_id
      t.integer :site_id
      t.string :building
      t.string :office
      t.string :floor
      t.time :morning_open
      t.time :morning_close
      t.time :afternoon_open
      t.time :afternoon_close
      t.string :details

      t.timestamps
    end
  end
end
