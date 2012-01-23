class Page < ActiveRecord::Base

  attr_accessible :title, :description, :content, :parent_id, :photo_id

  acts_as_nested_set

  belongs_to :photo
  has_many :contributions, :foreign_key => 'target_id'

  accepts_nested_attributes_for :contributions, :allow_destroy => true

  validates :title, :description, :content, :presence => true

  after_save :set_parent

#  default_scope :order => 'pages.title ASC'

  def to_param
    "#{id}-#{title.parameterize}"
  end

  private

    def set_parent
      move_to_child_of(parent_id) if !parent_id.nil?
    end

end
