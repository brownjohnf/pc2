class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :updated, :added, :to => :read
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    
    # all users, even non-logged in ones
    can :read, [ Page, CaseStudy, Photo, Document, Website, Blog, Library, Moment, Pcregion, Position, Sector, Staff, Stage ]
    can :index, [ User, Volunteer ]
    can :create, Feedback
    
    if user.role? :admin
      can :manage, :all
    elsif user.role? :user
      can :read, User
      can [ :update, :destroy ], User, :id => user.id
      if user.volunteers.any? || user.staff.any?
        can [ :create, :update ], [ Photo, Document, Website, Blog, Library, Moment, Volunteer, Staff ], :user_id => user.id
        can :create, [ Page, CaseStudy ], :country => user.country
        can [ :update, :destroy ], Page do |page|
          page.contributors.find_by_id(user.id)
        end
        can [ :update, :destroy ], CaseStudy do |cs|
          cs.contributors.find_by_id(user.id)
        end
      end
      if user.role? :moderator
        #can :manage, [ Page, CaseStudy ], :country => user.country
      end
    end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
