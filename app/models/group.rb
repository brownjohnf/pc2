class Group < ActiveRecord::Base

  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships

  has_many :permissions
  has_many :privileges, :through => :permissions
  has_many :scopes, :through => :permissions

  validates :name, :presence => true

  default_scope :order => 'groups.name ASC'

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
