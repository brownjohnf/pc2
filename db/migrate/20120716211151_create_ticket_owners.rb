class CreateTicketOwners < ActiveRecord::Migration
  def change
    create_table :ticket_owners do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :ticket_id
      t.integer :code_id

      t.timestamps
    end
  end
end
