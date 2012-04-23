class Document < ActiveRecord::Base

  require 'mp3info'

  # main document
  has_attached_file :file, {
    :storage => :s3,
    :bucket => ENV['S3_BUCKET'],
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }
  }
  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => [
    'audio/mpeg',
    'audio/mp3',
    'application/pdf',
    'text/plain',
    'text/csv',
    'text/xml',
    'text/html',
    'application/vnd.oasis.opendocument.spreadsheet',
    'application/vnd.oasis.opendocument.presentation',
    'application/vnd.ms-excel',
    'application/vnd.ms-powerpoint',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation', 
    'application/vnd.google-earth.kml+kml', 
    'application/x-latex',
    'application/x-shockwave-flash',
    'application/atom+xml',
    'application/rss+xml',
    'application/xhtml+xml'
  ]

  # source file for document, for archiving
  has_attached_file :source, {
    :storage => :s3,
    :bucket => ENV['S3_BUCKET'],
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }
  }
  validates_attachment_content_type :source, :content_type => [
    'text/plain', 
    'text/csv', 
    'text/xml', 
    'text/html', 
    'application/vnd.ms-excel', 
    'application/vnd.ms-powerpoint', 
    'application/vnd.google-earth.kml+kml',
    'application/x-latex', 
    'application/x-shockwave-flash',
    'application/zip',
    'application/x-gzip',
    'text/vcard',
    'application/msword',
    'application/vnd.ms-excel',
    'application/vnd.ms-powerpoint',
    'application/vnd.oasis.opendocument.text',
    'application/vnd.oasis.opendocument.spreadsheet',
    'application/vnd.oasis.opendocument.presentation',
    'application/vnd.oasis.opendocument.graphics', 
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation'
  ]
  
  acts_as_taggable_on :tags

  belongs_to :user
  belongs_to :language
  
  has_many :stacks, :as => :stackable, :dependent => :destroy
  has_many :libraries, :through => :stacks
  
  has_and_belongs_to_many :roles

  accepts_nested_attributes_for :stacks
  
  validates :name, :user_id, :country, :presence => true
  validates :file_fingerprint, :presence => true, :uniqueness => true
  validates :source_fingerprint, :uniqueness => true, :if => "source_file_name"
  validates :source_fingerprint, :presence => true, :if => "source_file_name"

  before_validation :clear_empty_attrs
  before_save :run_before_save
  after_save :run_after_save

  def canonical_title
    self.name
  end

  def formatted_audio_length
    if audio_length
      "#{audio_length.to_i / 3600}:#{sprintf("%02.f", audio_length.to_i / 60)}:#{sprintf("%02.f", audio_length.to_i - 60 * (audio_length.to_i / 60))}"
    end
  end

  def to_param
    "#{id}-#{canonical_title.parameterize}"
  end

  private

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
      self.name = self.file_file_name if name.nil?
    end

    def run_after_save
      if roles.empty?
        roles << Role.find_by_name('Public')
      end
    end

    def run_before_save
      if (file_content_type == 'audio/mpeg') || (file_content_type == 'audio/mp3')
        self.audio_length = Mp3Info.open(file.to_file).length.round
      end
    end

end
