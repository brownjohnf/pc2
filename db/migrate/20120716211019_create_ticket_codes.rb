class CreateTicketCodes < ActiveRecord::Migration
  def change
    create_table :ticket_codes do |t|
      t.string :name
      t.string :description
      t.string :color
      t.boolean :sender
      t.boolean :receiver
      t.integer :rank

      t.timestamps
    end
  end
end
