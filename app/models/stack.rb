class Stack < ActiveRecord::Base

  belongs_to :library
  belongs_to :user
  belongs_to :scope

  validates :library_id, :user_id, :scope_id, :target_id, :presence => true

  default_scope :order => 'stacks.scope_id ASC'

end
