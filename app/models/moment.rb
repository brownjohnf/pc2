class Moment < ActiveRecord::Base

  belongs_to :user
  belongs_to :country
  belongs_to :photo

  has_many :photos, :as => :imageable

  validates :title, :summary, :user_id, :datapoint, :presence => true
  accepts_nested_attributes_for :photos, :reject_if => lambda { |a| a[:photo].nil? }, :allow_destroy => true

  before_validation :set_values

  default_scope :order => 'moments.datapoint DESC'

  def to_param
    "#{id}-#{title.parameterize}"
  end

  private

    def set_values
      self.country_id = self.user.country.id# if country.nil?
    end

end
