class Authorization < ActiveRecord::Base

  belongs_to :user

  validates :provider, :uid, :presence => true

  def self.find_or_create(auth_hash)
    unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"].to_s)
      unless user = User.find_by_email(auth_hash["info"]["email"])
        user = User.create!(
          :name => auth_hash["info"]["name"], 
          :email => auth_hash["info"]["email"], 
          :bio => "#{auth_hash['info']['name']} has not yet created a bio. Check back later.")
      end
      auth = create :user => user, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
    # returns the auth object
    User.find_by_id(auth.user_id)
  end

end
