class TicketCode < ActiveRecord::Base

  has_many :ticket_updates
  has_many :ticket_owners
  has_many :tickets, :through => :ticket_updates
  
  default_scope :order => 'rank ASC'
  
end
