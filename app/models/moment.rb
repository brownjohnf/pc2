class Moment < ActiveRecord::Base

  acts_as_taggable_on :tags

  belongs_to :user
  belongs_to :photo

  has_many :photos, :as => :imageable

  validates :title, :summary, :user_id, :datapoint, :presence => true
  accepts_nested_attributes_for :photos, :reject_if => lambda { |a| a[:photo].nil? }, :allow_destroy => true

  before_validation :set_values

  default_scope :order => 'moments.datapoint DESC'

  def to_param
    "#{id}-#{title.parameterize}"
  end
    
  def self.random
    if (c = count) != 0
      find(:first, :offset =>rand(c))
    end
  end

  private

    def set_values
      self.country = self.user.country# if country.nil?
    end

end
