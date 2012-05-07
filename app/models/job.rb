class Job < ActiveRecord::Base

  belongs_to :staff
  belongs_to :position

  validates :staff_id, :position_id, :presence => true

end
