class Website < ActiveRecord::Base

  validates :name, :url, :presence => true

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
