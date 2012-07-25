class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :role_ids, :country, :bio, :email2, :phone1, :phone2, :tag_list, :blogs_attributes, :site, :volunteers_attributes, :staff_attributes, :avatar
  
  has_and_belongs_to_many :roles
  
  accepts_nested_attributes_for :roles, :allow_destroy => true
  validates :name, :presence => true, :length => { :minimum => 8, :maximum => 127 }, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }
  
  after_create :add_user_role

  has_attached_file :avatar, {
    :styles => { 
      :icon => '80x80#',
      :thumb => '100x100',
      :small => '200x200',
      :medium => '380x380',
      :large => '980x980>',
      :full => '1140x1140>'
    },
    :storage => :s3,
    :bucket => ENV['S3_BUCKET'],
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }
  }
  
  acts_as_taggable_on :tags
  acts_as_tagger

  has_many :volunteers
  has_many :staff

  # blogs, not necessarily by the user, but mostly
  has_many :blogs
  has_many :moments
  has_many :libraries
  has_many :documents

  # volunteer, staff, or host country national site locations
  has_many :sites

  # online websites
  has_many :websites
  
  # stacks for libraries in which the user is included
  has_many :stacked_in, :as => :stackable, :class_name => 'Stack', :dependent => :destroy

  # records of what stackables have been added to what libraries
  has_many :stacks
  
  # all photos directly uploaded by the user, just to upload. all photos are also tagged with the user_id of their uploader, 
  # even if they were uploaded as part of a timeline moment or something else.
  has_many :added_photos, :as => :imageable, :class_name => 'Photo'

  # all photos uploaded by the user, in any context
  has_many :photos
  
  # pages, case studies to which this user has contributed/is author
  has_many :contributions, :dependent => :destroy

  # support/grant tickets
  has_many :ticket_updates

  has_many :from, :foreign_key => :from_id, :class_name => 'TicketOwner', :dependent => :destroy
  has_many :sent_tickets, :through => :from, :source => :ticket, :uniq => true
  has_many :sent_to, :through => :from, :source => :to, :uniq => true

  has_many :to, :foreign_key => :to_id, :class_name => 'TicketOwner', :dependent => :destroy
  has_many :received_tickets, :through => :to, :source => :ticket, :uniq => true
  has_many :received_from, :through => :to, :source => :from, :uniq => true

  # if the user sets an already uploaded photo as a profile image
  belongs_to :photo

  before_validation :clear_empty_attrs
  before_destroy :reset_possessions

  accepts_nested_attributes_for :volunteers, :staff, :allow_destroy => true
  accepts_nested_attributes_for :blogs, :reject_if => lambda { |a| a[:url].blank? } 
  accepts_nested_attributes_for :documents, :photos

  default_scope :order => 'users.name ASC'
  
  def volunteer
    volunteers.current.first
  end

  def to_param
    name ? "#{id}-#{name.parameterize}" : id
  end

  def tickets
    sent_tickets + received_tickets
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password.
      User.create!(:name => "#{data.first_name} #{data.last_name}", :email => data.email, :password => Devise.friendly_token[0,20])
    end
  end
  
  def pc?(country = nil)
    if !! self.roles.find_by_name('Admin')
      return true
    elsif country
      return !!self.volunteers.find_by_country(country)
    else
      return !!self.volunteers
    end
  end

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  def countries
    countries = Hash.new
    volunteers.each do |v|
      countries[Carmen.country_name(v.country)] = v.country
    end
    staff.each do |s|
      countries[Carmen.country_name(s.country)] = s.country
    end
    countries
  end
  
  def country_list
    country_list = []
    self.countries.each do |name, code|
      country_list << code
    end
    country_list
  end

  def canonical_title
    self.name
  end

  private

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
    end
  
    def add_user_role
      self.roles << Role.find_by_name('User')
      self.roles << Role.find_by_name('Public')
    end

    def reset_possessions
      admin = User.find_by_name('Administrator')

      volunteers.each do |volunteer|
        volunteer.user = admin
        volunteer.save!
      end
      staff.each do |staff|
        staff.user = admin
        staff.save!
      end
      blogs.each do |blog|
        blog.user = admin
        blog.save!
      end
      moments.each do |moment|
        moment.user = admin
        moment.save!
      end
      libraries.each do |library|
        library.user = admin
        library.save!
      end
      sites.each do |site|
        site.user = admin
        site.save!
      end
      websites.each do |website|
        website.user = admin
        website.save!
      end
      stacks.each do |stack|
        stack.user = admin
        stack.save!
      end
      documents.each do |document|
        document.user = admin
        document.save!
      end
      photos.each do |photo|
        photo.user = admin
        photo.save!
      end
      added_photos.each do |added_photo|
        added_photo.imageable = admin
        added_photo.save!
      end
    end

end
