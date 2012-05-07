class Stage < ActiveRecord::Base

  has_many :volunteers
  has_many :users, :through => :volunteers
  
  validates :country, :name, :arrival, :swear_in, :cos, :presence => true

end
