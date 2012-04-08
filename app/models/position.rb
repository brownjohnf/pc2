class Position < ActiveRecord::Base

  has_many :jobs
  has_many :staff, :through => :jobs

  validates :title, :presence => true

  def to_param
    "#{id}-#{title.parameterize}"
  end

end
