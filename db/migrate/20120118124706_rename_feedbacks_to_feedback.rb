class RenameFeedbacksToFeedback < ActiveRecord::Migration
  def change
    rename_table :feedbacks, :feedback
  end
end
