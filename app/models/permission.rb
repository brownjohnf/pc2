class Permission < ActiveRecord::Base

  belongs_to :group
  belongs_to :user
  belongs_to :scope
  belongs_to :privilege

  validates :scope_id, :privilege_id, :presence => true

  default_scope :order => 'permissions.comment ASC'

end
