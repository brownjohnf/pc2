class Photo < ActiveRecord::Base

<<<<<<< HEAD
  # small is for span-4
  # medium is for span-8
  has_attached_file :photo,
    :styles => { :icon => '80x80#', :thumb => '100x100', :small => '200x200', :medium => '380x380', :large => '980x980>', :full => '1140x1140>' },
    :storage => :s3,
    :bucket => ENV['S3_BUCKET'],
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }
  validates_attachment_presence :photo
  validates_attachment_content_type :photo, :content_type => [
    'image/png',
    'image/jpg',
    'image/jpeg',
    'image/gif'
  ]

  acts_as_taggable_on :tags

  has_many :pages
  has_many :case_studies
  has_many :moments
  has_many :users
  
  has_many :stacks, :as => :stackable, :dependent => :destroy

  belongs_to :user
  belongs_to :imageable, :polymorphic => true

  accepts_nested_attributes_for :stacks

  before_validation :clear_empty_attrs
  validates :title, :imageable_id, :imageable_type, :user_id, :presence => true
  validates :description, :length => { :maximum => 255 }

  after_destroy :reset_pointers

  default_scope :order => 'photos.created_at DESC'

  def canonical_title
    self.title
  end

  def to_param
    "#{id}-#{canonical_title.parameterize}"
  end

  private

    def reset_pointers
      [User,Page,Moment,CaseStudy].each do |remove_from|
        remove_from.where(:photo_id => self).each do |u|
          u.photo = nil
          u.save
        end
      end
    end

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
      self.title = self.photo_file_name if title.nil?
    end

end
