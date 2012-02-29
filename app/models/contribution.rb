class Contribution < ActiveRecord::Base

  belongs_to :user
  belongs_to :contributable, :polymorphic => true
  
  validates :user_id, :contributable_id, :contributable_type, :presence => true

end
