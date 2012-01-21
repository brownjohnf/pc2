class Moment < ActiveRecord::Base

  belongs_to :user
  belongs_to :country

  validates :title, :summary, :photo_id, :user_id, :datapoint, :presence => true

  default_scope :order => 'moments.datapoint DESC'

end
