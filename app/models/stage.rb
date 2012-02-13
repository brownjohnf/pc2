class Stage < ActiveRecord::Base

  has_many :volunteers
  
  validates :country, :name, :arrival, :swear_in, :cos, :presence => true

end
