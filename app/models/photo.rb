class Photo < ActiveRecord::Base

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

  acts_as_taggable_on :tags

  has_many :pages
  has_many :case_studies
  has_many :moments
  has_many :users
  
  has_many :stacks, :as => :stackable, :dependent => :destroy

  belongs_to :imageable, :polymorphic => true
  belongs_to :user

  accepts_nested_attributes_for :stacks

  before_validation :clear_empty_attrs
  validates :title, :imageable_id, :imageable_type, :user_id, :presence => true
  validates :description, :length => { :maximum => 255 }

  after_destroy :reset_pointers

  default_scope :order => 'photos.created_at DESC'

  def canonical_title
    self.title
  end

  private

    def reset_pointers
      User.where(:photo_id => self).each do |u|
        u.photo_id = nil
        u.save
      end

      Page.where(:photo_id => self).each do |u|
        u.photo_id = nil
        u.save
      end

      Moment.where(:photo_id => self).each do |u|
        u.photo_id = nil
        u.save
      end
    end

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
      self.title = self.photo_file_name if title.nil?
    end

end
