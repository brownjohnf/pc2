class Volunteer < ActiveRecord::Base

  belongs_to :user
  belongs_to :stage
  belongs_to :site
  belongs_to :sector

  validates :site_id, :presence => true

  default_scope :order => 'volunteers.id ASC'

  def to_param
    "#{id}-#{user.name.parameterize}"
  end

end
