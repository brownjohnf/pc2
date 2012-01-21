class Staff < ActiveRecord::Base

  belongs_to :user
  belongs_to :site

  has_many :jobs
  has_many :positions, :through => :jobs

  validates :building, :site_id, :presence => true

  after_create :add_default_permissions

  def user_name
    user.name
  end

  private

    def add_default_permissions
      membership = self.user.memberships.build
      membership.group_id = 4
      membership.save
    end

end
