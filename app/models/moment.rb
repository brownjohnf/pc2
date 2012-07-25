class Moment < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::UrlHelper

  acts_as_taggable_on :tags

  belongs_to :user
  belongs_to :photo

  has_many :photos, :as => :imageable

  before_validation :clear_empty_attrs

  validates :user_id, :startdate, :country, :presence => true
  validates :caption, :length => { :maximum => 255 }
  validates :headline, :presence => true, :length => { :maximum => 255 }, :uniqueness => true
  validates :credit, :length => { :maximum => 255 }
  validates :years_of_service, :presence => true, :if => lambda { |moment| moment.credit.present? }
  validates :years_of_service, :length => { :maximum => 255 }
  validates :text, :uniqueness => true
  validates :media, :length => { :maximum => 500 }
  validates :media, :uniqueness => true, :if => lambda { |moment| moment.media.present? }
  validates :country, :presence => true, :if => lambda { |moment| moment.credit.present? }
  validates :region_id, :presence => true, :if => lambda { |moment| moment.credit.present? }
  validates :sector, :length => { :maximum => 255 }

  accepts_nested_attributes_for :photos, :reject_if => proc { |attributes| attributes['title'].blank? }, :allow_destroy => true

  before_validation :set_values

  default_scope :order => 'moments.startdate DESC'

  def to_param
    "#{id}-#{headline.parameterize}"
  end
    
  def self.random
    if (c = count) != 0
      find(:first, :offset =>rand(c))
    end
  end

  def select_media
    # if photo attached, use the photo
    if photos.any?
      photos.first.photo.url(:large)
    # otherwise, use the media
    elsif media.present?
      media
    # otherwise, use the headline
    else
      headline
    end
  end

  private

    def set_values
      self.country ||= (self.user ? self.user.country : nil)
    end

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
    end

end
