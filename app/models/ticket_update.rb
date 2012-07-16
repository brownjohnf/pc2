class TicketUpdate < ActiveRecord::Base

  belongs_to :ticket
  belongs_to :ticket_code
  belongs_to :user
  
  default_scope :order => 'created_at DESC'

end
