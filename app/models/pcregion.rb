class Pcregion < ActiveRecord::Base

  has_many :countries, :dependent => :destroy

  validates :name, :short, :presence => true

end
