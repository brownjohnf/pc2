class Regiontype < ActiveRecord::Base

  has_many :regions, :foreign_key => :type_id, :dependent => :destroy

  validates :name, :presence => true

  def to_param
    "#{id}-#{.parameterize}"
  end

end
