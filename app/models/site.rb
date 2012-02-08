class Site < ActiveRecord::Base

  has_many :volunteers
  has_many :staff
  
  belongs_to :region
  belongs_to :user

  validates :user_id, :name, :presence => true

end
