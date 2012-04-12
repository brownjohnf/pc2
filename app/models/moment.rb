class Moment < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  acts_as_taggable_on :tags

  belongs_to :user
  belongs_to :photo

  has_many :photos, :as => :imageable

  validates :title, :summary, :user_id, :datapoint, :country, :presence => true
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

  def text
    # if photo and content, use the photo for media, but link to full content here
    if photo && content
      ActiveSupport::JSON.encode('<p>' + summary + '</p><p><div style="display:inline-block;float:left;">' + user.name + '</div>Submitted by ' + user.name + '<br />' + Carmen.country_name(country) + '</p><p>' + truncate(content, :length => 150, :separator => ' ') + '</p>')
    # elsif no photo, but content, don't link to the content because it'll be used for media
    elsif content
      ActiveSupport::JSON.encode('<p>' + summary + '</p><p><div style="display:inline-block;float:left;">' + user.name + '</div>Submitted by ' + user.name + '<br />' + Carmen.country_name(country) + '</p>')
    # if no photo and no content, just show the contributor, because the summary will be used for media
    else
      ActiveSupport::JSON.encode('<p><div style="display:inline-block;float:left;">' + user.name + '</div>Submitted by ' + user.name + '<br />' + Carmen.country_name(country) + '</p>')
    end
  end

  def media
    # if photo and content, use the photo
    if photo && content
      ActiveSupport::JSON.encode(photo.photo.url)
    # if the content's short enough to likely be a URL (youtube, site, vimeo, etc.), use that
    elsif content && content.length < 100
      ActiveSupport::JSON.encode(content)
    # if there's content, use that
    elsif content
      ActiveSupport::JSON.encode('<blockquote>' + truncate(content, :length => 500, :separator => ' ') + '</blockquote>')
    # otherwise, use the summary. bummer.
    else
      ActiveSupport::JSON.encode('<blockquote>' + summary + '</blockquote>')
    end
  end

  def credit
    # if there's a photo, use the photo credit. otherwise, credit the submitting user
    ActiveSupport::JSON.encode(photo ? photo.user.name : user.name)
  end

  def caption
    # if there's a photo and it has a description, use that. otherwise, no caption.
    ActiveSupport::JSON.encode((photo && photo.description) ? photo.description : '')
  end

  private

    def set_values
      self.country ||= (self.user ? self.user.country : nil)
    end

end
