class Volunteer < ActiveRecord::Base

  belongs_to :user
#  belongs_to :stage
#  belongs_to :site
#  belongs_to :sector

  default_scope :order => 'volunteers.start DESC'

end
