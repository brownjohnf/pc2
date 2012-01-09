class Page < ActiveRecord::Base

  attr_accessible :title, :description, :content, :parent_id

  acts_as_nested_set

  validates :title, :description, :content, :presence => true

  after_save :set_parent

#  default_scope :order => 'pages.title ASC'

  private

    def set_parent
      move_to_child_of(parent_id) if !parent_id.nil?
    end

end
