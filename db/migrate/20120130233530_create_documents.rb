class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.has_attached_file :file

      t.timestamps
    end
  end
end
