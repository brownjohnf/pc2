class Moment < ActiveRecord::Base

  belongs_to :user
  belongs_to :country
  belongs_to :photo

  validates :title, :summary, :photo_id, :user_id, :datapoint, :presence => true

  default_scope :order => 'moments.datapoint DESC'

  def to_param
    "#{id}-#{title.parameterize}"
  end

end
