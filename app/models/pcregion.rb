class Pcregion < ActiveRecord::Base

  validates :name, :short, :presence => true

end
