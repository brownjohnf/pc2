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
    if photo && content
      ActiveSupport::JSON.encode('<p>' + summary + '</p><p><div style="display:inline-block;float:left;">' + user.name + '</div>Submitted by ' + user.name + '<br />' + Carmen.country_name(country) + '</p><p>' + truncate(content, :length => 150, :separator => ' ') + '</p>')
    elsif content
      ActiveSupport::JSON.encode('<p>' + summary + '</p><p><div style="display:inline-block;float:left;">' + user.name + '</div>Submitted by ' + user.name + '<br />' + Carmen.country_name(country) + '</p>')
    else
      ActiveSupport::JSON.encode('<p><div style="display:inline-block;float:left;">' + user.name + '</div>Submitted by ' + user.name + '<br />' + Carmen.country_name(country) + '</p>')
    end
  end

  def media
    if photo && content
      ActiveSupport::JSON.encode(photo.photo.url)
    elsif content && content.length < 100
      ActiveSupport::JSON.encode(content)
    elsif content
      ActiveSupport::JSON.encode('<blockquote>' + truncate(content, :length => 500, :separator => ' ') + '</blockquote>')
    else
      ActiveSupport::JSON.encode('<blockquote>' + summary + '</blockquote>')
    end
  end

  def credit
    ActiveSupport::JSON.encode(photo ? photo.user.name : user.name)
  end

  def caption
    ActiveSupport::JSON.encode((photo && photo.description) ? photo.description : summary)
  end

  private

    def set_values
      self.country ||= (self.user ? self.user.country : nil)
    end

end
