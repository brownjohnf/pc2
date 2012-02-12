class Page < ActiveRecord::Base

  attr_accessible :title, :description, :content, :parent_id, :photo_id, :language_id, :tag_list, :country

  acts_as_nested_set

  acts_as_taggable_on :tags

  belongs_to :photo
  belongs_to :language

  has_many :photos, :as => :imageable
  
  # first connects each one of this model to all of the contributables which which reference it
  # then connects to all users attached to all those connections by a renamed tunnel
  # through the contribution connection
  has_many :contributions, :as => :contributable, :dependent => :destroy
  has_many :contributors, :through => :contributions, :source => :user
  
  has_many :permissions, :as => :permissable, :dependent => :destroy
  has_many :groups, :through => :permissions
  has_many :users, :through => :groups

  accepts_nested_attributes_for :contributions, :allow_destroy => true

  before_validation :clear_empty_attrs
  validates :title, :description, :content, :language_id, :presence => true

  after_save :set_parent
  
  scope :pages_viewable_by, lambda { |user| viewable_by(user) }

  #default_scope :order => 'pages.title ASC'

  def to_param
    "#{id}-#{title.parameterize}"
  end

  private

    def self.viewable_by(user)
      allowed = user.permissions.where(:permissable_type => 'Page')
      allowed_ids = []
      allowed.each do |a|
        allowed_ids << a.permissable.id
      end
      where(:id => allowed_ids)
    end

    def set_parent
      move_to_child_of(parent_id) if !parent_id.nil?
    end

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
    end

end
