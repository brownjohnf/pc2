class Site < ActiveRecord::Base

  has_many :volunteers
  has_many :staff
  belongs_to :region

end
