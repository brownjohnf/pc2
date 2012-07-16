class Ticket < ActiveRecord::Base

  belongs_to :ticket_category
  belongs_to :priority
  
  has_many :ticket_updates, :dependent => :destroy
  has_many :ticket_codes, :through => :ticket_updates
  
  has_many :ticket_owners, :dependent => :destroy
  has_many :sent_by, :through => :ticket_owners, :source => :from
  has_many :sent_to, :through => :ticket_owners, :source => :to
  
  validates :priority_id, :presence => true
  validates :ticket_category_id, :presence => true
  
  accepts_nested_attributes_for :ticket_updates
  accepts_nested_attributes_for :ticket_owners
  
  default_scope :order => 'created_at DESC'
  
  def set_update!(code)
    updates.create!(:code_id => code)
  end

end
