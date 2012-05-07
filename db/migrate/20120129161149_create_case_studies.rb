class CreateCaseStudies < ActiveRecord::Migration
  def change
    create_table :case_studies do |t|
      t.string :title
      t.integer :photo_id
      t.integer :language_id
      t.text :summary
      t.text :context
      t.text :approach
      t.text :results
      t.text :challenges
      t.text :lessons_learned
      t.text :next_steps

      t.timestamps
    end
  end
end
