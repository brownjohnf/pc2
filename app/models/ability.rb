class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :updated, :added, :download, :search, :feed, :podcast, :table, :ajax, :to => :read
    alias_action :mercury_update, :to => :update
    # Define abilities for the passed in user here. For example:
    #
    unless user
      user = User.new # guest user (not logged in)
      user.roles << Role.find_by_name('Public')
    end
    
    # all users, even non-logged in ones
    can :read, [ Page, CaseStudy, Photo, Website, Blog, Library, Moment, PcRegion, Position, Sector, Stage, User ]
    can :index, [ Volunteer, Staff ]
    cannot :table, [ User, Volunteer, Staff ]
    
    can :create, Feedback

    can :read, Document do |item|
      item.roles.where(:id => user.roles).any?
    end
    
    if user.role? :admin
      can :manage, :all
      cannot [ :create, :destroy ], SiteConfig

    elsif user.role? :user
      can :read, :welcome
      can :read, Region
      can [ :update, :destroy ], User, :id => user.id
      can [ :update, :destroy ], Moment, :user_id => user.id
      can :update, Photo, :user_id => user.id
      can :volunteer_request, Feedback

      can [ :update ], Page do |page|
        page.contributors.find_by_id(user.id)
      end
      can [ :update ], CaseStudy do |cs|
        cs.contributors.find_by_id(user.id)
      end

      can :download_source, Document, :user_id => user.id

      if user.role?(:volunteer) || user.role?(:staff)
        can :read, [ User, Volunteer, Staff ]

        can :create, [ Page, CaseStudy, Region, Stage, Moment ]
        can :manage, [ Moment, Photo, Document, Website, Blog, Library ], :user_id => user.id
        can [ :read, :create, :update ], [ Volunteer, Staff ], :user_id => user.id
        can [ :create, :destroy], Stack, :user_id => user.id

        can :create, Site do |site|
          site.region.country = user.country
        end

      end
      if user.role? :moderator
        can :manage, [ Document, Photo, Library, Moment ] do |item|
          user.country_list.include?(item.country)
        end
        can [ :update, :destroy ], Page do |item|
          user.country_list.include?(item.country)
        end
        can :download_source, Document
        can :manage, [ Stage, Stack, Contribution ]
        can :read, Feedback
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
