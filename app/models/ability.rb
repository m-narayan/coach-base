class Ability
  include SocialStream::Ability

  def initialize(subject)
    super

   can :read , :all
  end
end