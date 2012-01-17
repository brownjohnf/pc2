class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :group

  default_scope :order => 'memberships.user_id ASC'

end
