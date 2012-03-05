class Stack < ActiveRecord::Base

  belongs_to :stackable, :polymorphic => true
  belongs_to :document, :foreign_key => :stackable_id
  belongs_to :photo, :foreign_key => :stackable_id

  belongs_to :library
  belongs_to :user

  validates :library_id, :user_id, :stackable_id, :stackable_type, :presence => true

end
