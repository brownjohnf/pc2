class Regiontype < ActiveRecord::Base

  has_many :regions, :foreign_key => :type_id

  validates :name, :presence => true

end
