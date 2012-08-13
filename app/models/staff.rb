class Staff < ActiveRecord::Base

  belongs_to :user
  belongs_to :site

  has_many :jobs
  has_many :positions, :through => :jobs

  validates :user_id, :country, :presence => true

  after_create :add_to_staff
  after_destroy :remove_from_staff
  after_commit :after_commit

  def user_name
    user.name
  end

  def to_param
    "#{id}-#{user.name.parameterize}"
  end

  def percent_complete
    counter = 0
    attrs = [
      :building,
      :office,
      :floor,
      :morning_open,
      :morning_close,
      :afternoon_open,
      :afternoon_close,
      :details
    ]
    attrs.each { |attr| counter += 1 unless self[attr].blank? }
    counter.to_f / attrs.count.to_f * 100
  end

  private
    
    def add_to_staff
      self.user.roles << Role.find_by_name('Staff')
    end
    
    def remove_from_staff
      self.user.roles.delete(Role.find_by_name('Staff')) unless self.user.staff.any?
    end

    def after_commit
      user.update_percentage
    end

end
