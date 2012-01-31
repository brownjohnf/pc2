class Website < ActiveRecord::Base

  acts_as_taggable_on :tags

  validates :name, :url, :presence => true

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
