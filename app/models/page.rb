class Page < ActiveRecord::Base

  attr_accessible :title, :description, :content, :parent_id, :photo_id, :language_id

  acts_as_nested_set

  belongs_to :photo
  belongs_to :language

  has_many :contributions, :foreign_key => 'target_id'
  has_many :photos, :as => :imageable

  accepts_nested_attributes_for :contributions, :allow_destroy => true

  before_validation :clear_empty_attrs
  validates :title, :description, :content, :language_id, :presence => true

  after_save :set_parent

  #default_scope :order => 'pages.title ASC'

  def to_param
    "#{id}-#{title.parameterize}"
  end

  private

    def set_parent
      move_to_child_of(parent_id) if !parent_id.nil?
    end

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
    end

end
