class Country < ActiveRecord::Base

  has_many :regions
  belongs_to :pcregion

  validates :name, :short, :pcregion_id, :presence => true

end
