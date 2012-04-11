class Document < ActiveRecord::Base

  has_attached_file :file,
    :storage => :s3,
    :bucket => ENV['S3_BUCKET'],
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }
  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => [
    'application/mp3',
    'audio/mp3',
    'text/plain',
    'text/xml'
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
  after_save :check_roles

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

    def check_roles
      if roles.empty?
        roles << Role.find_by_name('Public')
      end
    end

end
