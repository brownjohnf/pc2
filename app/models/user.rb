class User < ActiveRecord::Base

  has_attached_file :avatar, :styles => { :icon => '100x100#', :thumb => '150x150', :small => '255x255', :medium => '350x350', :large => '980x980' }
  acts_as_taggable_on :tags
  acts_as_tagger

  has_many :memberships, :dependent => :destroy
  has_many :groups, :through => :memberships

  has_many :permissions, :dependent => :destroy
  has_many :privileges, :through => :permissions

  has_many :authorizations, :dependent => :destroy
  has_many :volunteers, :dependent => :destroy
  has_many :staff, :dependent => :destroy
  has_many :contributions, :dependent => :destroy
  has_many :blogs
  has_many :moments
  has_many :stacks, :as => :stackable
  has_many :added_stacks, :as => :user
  has_many :libraries
  has_many :photos, :as => :imageable
  has_many :uploaded_photos, :as => :user
  has_many :documents

  belongs_to :country
  belongs_to :photo

  before_validation :clear_empty_attrs
  validates :name, :email, :country_id, :presence => true

  accepts_nested_attributes_for :memberships, :volunteers, :staff, :allow_destroy => true
  accepts_nested_attributes_for :blogs

  before_create :make_salt

  default_scope :order => 'users.name ASC'

  def add_provider(auth_hash)
    # Check if the provider already exists, so we don't add it twice
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"].to_s)
      Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def admin?
    Group.find_by_name('Administrator').users.find_by_id(self)
  end

  def moderator?
    unless self.admin?
      Group.find_by_name('Moderator').users.find_by_id(self)
    else
      true
    end
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def destroy_avatar
    self.avatar = nil
    self.save
  end

  private

    def make_salt
      self.salt = secure_hash("#{Time.now.utc}--#{self.name}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
    end

end
