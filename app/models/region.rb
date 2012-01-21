class Region < ActiveRecord::Base

  belongs_to :country
  belongs_to :type, :class_name => 'Regiontype'

  has_many :sites

  validates :name, :short, :country_id, :type_id, :presence => true

end
