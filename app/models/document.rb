class Document < ActiveRecord::Base

  require 'mp3info'

  has_attached_file :file
  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => [
    'audio/mpeg',
    'application/pdf',
    'text/plain',
    'text/csv',
    'text/html',
    'text/xml',
    'application/vnd.ms-excel',
    'application/vnd.ms-powerpoint',
    'application/vnd.google-earth.kml+kml',
    'application/x-latex',
    'application/x-shockwave-flash'
  ]
  
  acts_as_taggable_on :tags

  belongs_to :user
  belongs_to :language
  
  has_many :stacks, :as => :stackable, :dependent => :destroy
  has_many :libraries, :through => :stacks
  
  has_and_belongs_to_many :roles

  accepts_nested_attributes_for :stacks
  
  validates :name, :user_id, :presence => true

  before_validation :clear_empty_attrs
  before_save :run_before_save
  after_save :run_after_save

  def canonical_title
    self.name
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
      if file_content_type == 'audio/mpeg'
        self.audio_length = Mp3Info.open(file.to_file).length.round
      end
    end

end
