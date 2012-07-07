class SiteConfig < ActiveRecord::Base

  has_attached_file :photo, {
    :styles => {
      :icon => '80x80#',
      :thumb => '100x100',
      :small => '200x200',
      :spotlight => '360x230#',
      :medium => '380x380',
      :large => '980x980',
      :wide => '980x400#',
      :full => '1140x1140>'
    },
    :convert_options => { :all => "-auto-orient" },
    :storage => :s3,
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    },
    :url => :s3_alias_url,
    :s3_host_alias => ENV['CDN_NAME'],
    :bucket => ENV['S3_BUCKET'],
    :path => 'config_photos/:id/:style/:filename'
  }
  validates_attachment_content_type :photo, :content_type => [
    'image/png',
    'image/jpeg',
    'image/pjpeg',
    'image/gif'
  ]

  has_attached_file :file, {
    :storage => :s3,
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    },
    :s3_host_alias => ENV['CDN_NAME'],
    :bucket => ENV['S3_BUCKET'],
    :path => 'config_files/:id/:style/:filename'
  }
  validates_attachment_content_type :file, :content_type => [
    'text/plain'
  ]

  validates :name, :setting, :presence => true

  default_scope :order => 'name ASC' 

  def to_param
    "#{id}-#{name}"
  end

  private

    def clear_empty_attributes
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
    end

end
