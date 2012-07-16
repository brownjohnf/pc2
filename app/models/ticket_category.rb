class TicketCategory < ActiveRecord::Base
  
  has_many :tickets
  
  default_scope :order => 'name ASC'
  
end
