class Setting < ActiveRecord::Base

  validates :property, :value, :presence => true
  
end
