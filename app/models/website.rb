class Website < ActiveRecord::Base

  validates :name, :url, :presence => true

end
