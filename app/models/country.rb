class Country < ActiveRecord::Base

  has_many :regions, :dependent => :destroy
  has_many :users, :dependent => :destroy
  has_many :moments, :dependent => :destroy
  has_many :libraries

  belongs_to :pcregion

  validates :name, :short, :pcregion_id, :presence => true

  default_scope :order => 'countries.name ASC'

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
