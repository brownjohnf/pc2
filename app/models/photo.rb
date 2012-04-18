# @author John Brown
# General photo class. Holds photos for various other models. It has attached files in various sizes.
#
# @return [Object] photo has the following sizes: icon(80x80#), thumb(100x100), small(200x200), spotlight(360x230#), medium(380x380), large(980x980>), wide(980x400#), full(1140x1140>)
#
class Photo < ActiveRecord::Base

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
  validates_attachment_presence :photo
  validates_attachment_content_type :photo, :content_type => [
    'image/png',
    'image/jpeg',
    'image/pjpeg',
    'image/gif'
  ]

  acts_as_taggable_on :tags

  has_many :pages
  has_many :case_studies
  has_many :moments
  has_many :users
  
  has_many :stacks, :as => :stackable, :dependent => :destroy
  has_many :libraries, :through => :stacks

  belongs_to :user
  belongs_to :imageable, :polymorphic => true

  accepts_nested_attributes_for :stacks

  before_validation :clear_empty_attrs
  validates :title, :imageable_id, :imageable_type, :user_id, :presence => true
  validates :description, :length => { :maximum => 255 }
  validates :photo_fingerprint, :uniqueness => true, :presence => true

  after_destroy :reset_pointers

  default_scope :order => 'photos.created_at DESC'
  
  # Return a standard title. Used as a handle for reference from views 
  # if you don't know what the object is with which you'reworking.
  #
  # @return [String] canonical_title
  #
  def canonical_title
    self.title
  end

  # Add the title to the address, for improved readability.
  #
  # @return [String] to_param in the form of id-canonical_title
  #
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
