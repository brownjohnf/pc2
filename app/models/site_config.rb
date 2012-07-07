class SiteConfig < ActiveRecord::Base

  has_attached_file :photo, {
    :styles => {
      :icon => '80x80#',
      :thumb => '100x100',
      :small => '200x200',
      :spotlight => '360x230#',
      :medium => '380x380',
      :large => '980x980>',
      :wide => '980x400#',
      :full => '1140x1140>'
    },
    :path => "public/system/#{Rails.env}/:attachment/:id/:style/:filename",
    :url => "/system/#{Rails.env}/:attachment/:id/:style/:filename"
  }
  validates_attachment_content_type :photo, :content_type => [
    'image/png',
    'image/jpeg',
    'image/pjpeg',
    'image/gif'
  ]

  has_attached_file :file, {
    :path => "public/system/#{Rails.env}/:attachment/:id/:style/:filename",
    :url => "/system/#{Rails.env}/:attachment/:id/:style/:filename"
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
