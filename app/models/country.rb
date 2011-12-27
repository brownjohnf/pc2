class Country < ActiveRecord::Base

  has_many :regions, :dependent => :destroy
  has_many :users, :dependent => :destroy
  belongs_to :pcregion

  validates :name, :short, :pcregion_id, :presence => true

end
