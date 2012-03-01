class Staff < ActiveRecord::Base

  belongs_to :user
  belongs_to :site

  has_many :jobs
  has_many :positions, :through => :jobs

  validates :user_id, :country, :presence => true

  after_create :add_to_staff
  after_destroy :remove_from_staff

  def user_name
    user.name
  end

  def to_param
    "#{id}-#{user.name.parameterize}"
  end

  private
    
    def add_to_staff
      self.user.roles << Role.find_by_name('Staff')
    end
    
    def remove_from_staff
      self.user.roles.delete(Role.find_by_name('Staff')) unless self.user.staff.any?
    end

end
