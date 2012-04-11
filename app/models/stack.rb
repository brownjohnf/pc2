class Stack < ActiveRecord::Base

  # the object being 'stacked'
  belongs_to :stackable, :polymorphic => true

  # legacy
  # belongs_to :document, :foreign_key => :stackable_id
  # belongs_to :photo, :foreign_key => :stackable_id

  # where it's being stacked
  belongs_to :library

  # who stacked it
  belongs_to :user

  # validations; everything's required, as this is basically a join table
  validates :library_id, :user_id, :stackable_id, :stackable_type, :presence => true

end
