class Volunteer < ActiveRecord::Base

  belongs_to :user
  belongs_to :stage
  belongs_to :site
  belongs_to :sector

  validates :user_id, :country, :presence => true

  default_scope :order => 'cos_date DESC'
  scope :current, lambda { joins(:stage).where("cos_date > ?", Time.now).where("swear_in < ?", Time.now) }
  
  after_create :add_to_volunteers
  after_commit :after_commit
  after_destroy :remove_from_volunteers

  def swear_in_date
    stage.swear_in
  end

  def to_param
    "#{id}-#{user.name.parameterize}"
  end

  def percent_complete
    counter = 0
    attrs = [
      :emphasis,
      :projects,
      :stage_id,
      :local_name,
      :site_id,
      :sector_id,
      :cos_date
    ]
    attrs.each { |attr| counter += 1 unless self[attr].blank? }
    counter.to_f / attrs.count.to_f * 100
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

    def after_commit
      user.update_percentage
    end

end
