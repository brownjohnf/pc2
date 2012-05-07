class AddAudioLengthToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :audio_length, :integer
  end
end
