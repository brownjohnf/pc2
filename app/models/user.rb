class User < ActiveRecord::Base

  has_many :memberships, :dependent => :destroy
  has_many :groups, :through => :memberships

  has_many :permissions, :dependent => :destroy
  has_many :privileges, :through => :permissions

  has_many :authorizations, :dependent => :destroy
  has_many :volunteers, :dependent => :destroy
  has_many :contributions, :dependent => :destroy
  has_many :blogs

  belongs_to :country

  before_validation :clear_empty_attrs
  validates :name, :email, :presence => true

  accepts_nested_attributes_for :memberships, :volunteers, :allow_destroy => true
  accepts_nested_attributes_for :blogs

  before_create :make_salt
  after_create :add_default_permissions

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
    admin = Group.find_by_name('Moderator').users.find_by_id(self)
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
