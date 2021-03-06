class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new # guest user (not logged in)

    # if a member, they can manage their own posts 
    # (or create new ones)
    if user.role? :member
      can :manage, Post, :user_id => user.id
      can :manage, Comment, :user_id => user.id
      can :create, Vote
      can :manage, Favorite, user_id: user.id
      can :read, Topic
    end

    # Moderators can delete any post
    if user.role? :moderator
      can :destroy, Post
      can :destroy, Comment
    end

    if user.role? :admin
      can :manage, :all
    end

    can :read, Topic, public: true
    can :read, Post
  end
end
