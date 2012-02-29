class Group < ActiveRecord::Base

  validates :name, :presence => true

  default_scope :order => 'groups.name ASC'

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
