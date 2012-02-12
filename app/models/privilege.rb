class Privilege < ActiveRecord::Base

  has_many :permissions, :dependent => :destroy

  validates :name, :description, :presence => true

  default_scope :order => 'privileges.name ASC'

end
