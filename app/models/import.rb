class Import < ActiveRecord::Base

  has_attached_file :csv, {
    :path => "public/system/#{Rails.env}/:attachment/:id/:style/:filename",
    :url => "/system/#{Rails.env}/:attachment/:id/:style/:filename"
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
