class Library < ActiveRecord::Base

  has_many :stacks, :dependent => :destroy

  belongs_to :country
  belongs_to :user

  validates :name, :presence => true

  def to_param
    "#{id}-#{name.parameterize}"
  end

end