class Contribution < ActiveRecord::Base

  belongs_to :user
  belongs_to :scope

  def target_title
    scope.name.constantize.find_by_id(target_id).title
  end

end
