class CreateTicketCodes < ActiveRecord::Migration
  def change
    create_table :ticket_codes do |t|
      t.string :name
      t.string :past_name
      t.string :verb, :default => 'to'
      t.string :description
      t.string :color
      t.boolean :sender
      t.boolean :receiver
      t.integer :rank

      t.timestamps
    end
  end
end
