class Scope < ActiveRecord::Base

  has_many :permissions

  validates :name, :description, :presence => true

  default_scope :order => 'scopes.name ASC'

end
