class CreateTicketUpdates < ActiveRecord::Migration
  def change
    create_table :ticket_updates do |t|
      t.integer :ticket_id
      t.integer :ticket_code_id, :default => 1
      t.string :comment, :default => 'New ticket.'
      t.integer :user_id

      t.timestamps
    end
  end
end
