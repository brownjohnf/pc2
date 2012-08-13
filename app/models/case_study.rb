class CaseStudy < ActiveRecord::Base

  acts_as_taggable_on :tags, :settings

  validates :title, :language_id, :summary, :country, :presence => true
  
  # first connects each one of this model to all of the contributables which which reference it
  # then connects to all users attached to all those connections by a renamed tunnel
  # through the contribution connection
  has_many :contributions, :as => :contributable, :dependent => :destroy
  has_many :contributors, :through => :contributions, :source => :user
  has_many :stacks, :as => :stackable, :dependent => :destroy
  has_many :libraries, :through => :stacks

  belongs_to :language
  belongs_to :photo

  accepts_nested_attributes_for :stacks

  before_save :clear_empty_attrs
  after_commit :do_after_commit
  
  default_scope :order => 'updated_at DESC'

  def canonical_title
    self.title
  end

  def to_param
    "#{id}-#{canonical_title.parameterize}"
  end

  private

    def do_after_commit
      tags.each do |tag|
        REDIS.multi do
          REDIS.zincrby('tags', 1, tag.name)
          REDIS.zincrby('case_studies:tags', 1, tag.name)
          REDIS.sadd("case_studies:#{id}:tags", tag.name)
        end
      end
    end      

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
    end

end
