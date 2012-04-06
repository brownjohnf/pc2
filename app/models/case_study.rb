class CaseStudy < ActiveRecord::Base

  acts_as_taggable_on :tags

  validates :title, :language_id, :summary, :country, :presence => true
  
  # first connects each one of this model to all of the contributables which which reference it
  # then connects to all users attached to all those connections by a renamed tunnel
  # through the contribution connection
  has_many :contributions, :as => :contributable, :dependent => :destroy
  has_many :contributors, :through => :contributions, :source => :user

  belongs_to :language
  belongs_to :photo

  before_save :clear_empty_attrs
  
  default_scope :order => 'updated_at DESC'

  private

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
    end

end
