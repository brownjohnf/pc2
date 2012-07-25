class Volunteer < ActiveRecord::Base

  belongs_to :user
  belongs_to :stage
  belongs_to :site
  belongs_to :sector

  validates :user_id, :country, :presence => true

  default_scope :order => 'cos_date DESC'
  scope :current, lambda { joins(:stage).where("cos_date > ?", Time.now).where("swear_in < ?", Time.now) }
  
  after_create :add_to_volunteers
  after_destroy :remove_from_volunteers

  def swear_in_date
    stage.swear_in
  end

  def to_param
    "#{id}-#{user.name.parameterize}"
  end
  
  private
    
    def add_to_volunteers
      self.user.roles << Role.find_by_name('Volunteer')
      self.user.roles.delete(Role.find_by_name('Invitee'))
      self.user.roles.delete(Role.find_by_name('Trainee'))
    end
    
    def remove_from_volunteers
      self.user.roles.delete(Role.find_by_name('Volunteer')) unless self.user.volunteers.any?
    end

end
