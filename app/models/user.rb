class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :role_ids, :country, :bio, :email2, :phone1, :phone2, :tag_list, :blogs_attributes, :site, :volunteers_attributes, :staff_attributes
  
  has_and_belongs_to_many :roles
  
  accepts_nested_attributes_for :roles, :allow_destroy => true
  validates :name, :email, :presence => true
  
  after_create :add_user_role

  has_attached_file :avatar, :styles => { :icon => '100x100#', :thumb => '150x150', :small => '255x255', :medium => '350x350', :large => '980x980' },
    :storage => :s3,
    :bucket => 'pcsenegal-dev-com',
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }
  acts_as_taggable_on :tags
  acts_as_tagger

  has_many :memberships, :dependent => :destroy
  has_many :groups, :through => :memberships
  has_many :permissions, :through => :groups
  has_many :privileges, :through => :permissions

  has_many :volunteers, :dependent => :destroy
  has_many :staff, :dependent => :destroy
  has_many :blogs, :dependent => :destroy
  has_many :moments, :dependent => :destroy
  has_many :libraries, :dependent => :destroy
  has_many :documents
  has_many :sites
  has_many :websites
  
  has_many :stacks, :as => :stackable
  has_many :added_stacks, :as => :user
  
  # all photos directly uploaded by the user, just to upload. all photos are also tagged with the user_id of their uploader, 
  # even if they were uploaded as part of a timeline moment or something else.
  has_many :photos, :as => :imageable
  
  # pages, case studies to which this user has contributed/is author
  has_many :contributions, :dependent => :destroy

  # if the user sets an already uploaded photo as a profile image
  belongs_to :photo

  before_validation :clear_empty_attrs

  accepts_nested_attributes_for :memberships, :volunteers, :staff, :allow_destroy => true
  accepts_nested_attributes_for :blogs, :reject_if => lambda { |a| a[:url].blank? } 
  accepts_nested_attributes_for :documents, :photos

  default_scope :order => 'users.name ASC'

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def destroy_avatar
    self.avatar = nil
    self.save
  end
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password.
      User.create!(:name => "#{data.first_name} #{data.last_name}", :email => data.email, :password => Devise.friendly_token[0,20])
    end
  end
  
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  private

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
    end
  
    def add_user_role
      self.roles << Role.find_by_name('User')
    end

end
