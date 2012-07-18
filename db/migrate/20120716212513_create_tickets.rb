class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :ref_id
      t.integer :ticket_category_id
      t.string :subject
      t.string :body
      t.integer :priority_id

      t.timestamps
    end
  end
end
