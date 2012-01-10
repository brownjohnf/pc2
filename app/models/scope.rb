class Scope < ActiveRecord::Base

  has_many :permissions
  has_many :contributions

  validates :name, :description, :title, :presence => true

  default_scope :order => 'scopes.name ASC'

end
