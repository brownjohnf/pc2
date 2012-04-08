class Site < ActiveRecord::Base

  has_many :volunteers
  has_many :staff
  
  belongs_to :region
  belongs_to :user

  validates :user_id, :name, :presence => true

  def canonical_title
    self.name
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
