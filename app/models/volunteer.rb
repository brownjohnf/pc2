class Volunteer < ActiveRecord::Base

  belongs_to :user
  belongs_to :stage
  belongs_to :site
  belongs_to :sector

  validates :user_id, :country, :presence => true

  default_scope :order => 'cos_date DESC'

  def to_param
    "#{id}-#{user.name.parameterize}"
  end

end
