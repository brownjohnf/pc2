class Membership < ActiveRecord::Base

  default_scope :order => 'memberships.user_id ASC'

end
