class Privilege < ActiveRecord::Base

  has_many :permissions

  validates :name, :description, :presence => true

  default_scope :order => 'privileges.name ASC'

end
