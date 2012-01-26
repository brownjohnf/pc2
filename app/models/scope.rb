class Scope < ActiveRecord::Base

  has_many :permissions, :dependent => :destroy
  has_many :contributions, :dependent => :destroy
  has_many :imports, :dependent => :destroy

  validates :name, :description, :title, :presence => true

  default_scope :order => 'scopes.name ASC'

end
