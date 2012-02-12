class CreateFeedback < ActiveRecord::Migration
  def change
    create_table :feedback do |t|
      t.string :subject
      t.text :content

      t.timestamps
    end
  end
end
