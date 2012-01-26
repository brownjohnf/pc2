class Stack < ActiveRecord::Base

  belongs_to :stackable, :polymorphic => true

  belongs_to :library
  belongs_to :user

  validates :library_id, :user_id, :stackable_id, :stackable_type, :presence => true

  default_scope :order => 'stacks.stackable_type ASC'

end
