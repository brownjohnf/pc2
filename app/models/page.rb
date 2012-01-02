class Page < ActiveRecord::Base

  attr_accessible :title, :description, :content, :parent_id

  acts_as_nested_set

  validates :title, :description, :content, :presence => true

#  default_scope :order => 'pages.title ASC'

  def set_parent
    move_to_child_of(parent_id)
  end

end
