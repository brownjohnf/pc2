class Priority < ActiveRecord::Base

  has_many :tickets
  
  default_scope :order => 'level ASC'
  
end
