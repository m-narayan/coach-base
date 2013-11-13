class Ability
  include SocialStream::Ability

  def initialize(subject)
    super

   can :manage , :all
  end
end