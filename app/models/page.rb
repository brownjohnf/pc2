class Page < ActiveRecord::Base

  attr_accessible :title, :description, :content, :parent_id, :photo_id, :language_id, :tag_list, :setting_list, :country, :sort_by, :sort_order, :created_at

  acts_as_nested_set

  acts_as_taggable_on :tags, :settings

  belongs_to :photo
  belongs_to :language

  has_many :photos, :as => :imageable

  # for library/stack association
  has_many :stacks, :as => :stackable, :dependent => :destroy
  has_many :libraries, :through => :stacks
  
  # first connects each one of this model to all of the contributables which which reference it
  # then connects to all users attached to all those connections by a renamed tunnel
  # through the contribution connection
  has_many :contributions, :as => :contributable, :dependent => :destroy
  has_many :contributors, :through => :contributions, :source => :user

  accepts_nested_attributes_for :contributions, :allow_destroy => true

  before_validation :clear_empty_attrs
  validates :title, :description, :content, :language_id, :presence => true

  after_save :set_parent
  before_destroy :reset_children
  
  #default_scope :order => 'title ASC'

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def canonical_title
    self.title
  end

  private

    def set_parent
      unless parent_id.nil?
        if self.country == self.parent.country
          move_to_child_of(parent_id)
        else
          self.parent_id = nil
          self.save
        end
      end 
      self.descendants.each do |d|
        d.country = self.country
        d.save
      end
    end
    
    def reset_children
      if self.parent_id
        self.children.each do |child|
          child.move_to_child_of(self.parent_id)
        end
      else
        self.children.each do |child|
          child.parent_id = nil
          child.save
        end
      end
    end

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
    end

end
