class Import < ActiveRecord::Base

  has_attached_file :csv, {
    :storage => :s3,
    :bucket => ENV['S3_BUCKET'],
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }
  }
  validates_attachment_presence :csv

  belongs_to :scope

  validates :scope_id, :name, :presence => true

  #before_create :set_unproc

  private

    def set_unproc
      self.processed = false
    end

end
