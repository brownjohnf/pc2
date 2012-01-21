class Site < ActiveRecord::Base

  has_many :volunteers
  belongs_to :region

end
