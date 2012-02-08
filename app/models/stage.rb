class Stage < ActiveRecord::Base

  belongs_to :user
  
  validates :user_id, :name, :arrival, :swear_in, :cos, :presence => true

end
