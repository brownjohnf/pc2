class Staff < ActiveRecord::Base

  belongs_to :user
  belongs_to :site

  has_many :jobs
  has_many :positions, :through => :jobs

  validates :user_id, :country, :presence => true

  after_create :add_default_permissions

  def user_name
    user.name
  end

  def to_param
    "#{id}-#{user.name.parameterize}"
  end

  private

    def add_default_permissions
      membership = self.user.memberships.build
      membership.group_id = 4
      membership.save
    end

end
