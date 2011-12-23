class Pcregion < ActiveRecord::Base

  has_many :countries

  validates :name, :short, :presence => true

end
