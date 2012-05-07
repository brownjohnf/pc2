class PcRegion < ActiveRecord::Base

  validates :name, :short, :presence => true

end
