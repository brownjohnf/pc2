class Sector < ActiveRecord::Base

  has_many :volunteers

  validates :name, :presence => true

end
