class Region < ActiveRecord::Base

  belongs_to :type, :class_name => 'Regiontype'

  has_many :sites

  validates :name, :short, :country, :type_id, :presence => true

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
