class Contribution < ActiveRecord::Base

  belongs_to :user
  belongs_to :scope
  belongs_to :page

  def target_title
    if target_path.title
      target_path.title
    else
      target_path.name
    end
  end

  def target_path
    scope.name.constantize.find_by_id(target_id)
  end

end
