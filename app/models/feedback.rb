class Feedback < ActiveRecord::Base

  validates :subject, :content, :presence => true

  def to_param
    "#{id}-#{subject.parameterize}"
  end

end
