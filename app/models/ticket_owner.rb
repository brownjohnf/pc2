class TicketOwner < ActiveRecord::Base

  belongs_to :ticket
  belongs_to :ticket_code
  belongs_to :outgoing, :class_name => 'User'
  belongs_to :incoming, :class_name => 'User'
  belongs_to :to, :class_name => 'User'
  belongs_to :from, :class_name => 'User'
  
  default_scope :order => 'created_at DESC'
  
end
