class Course < ActiveRecord::Base
  include SocialStream::Models::Object
  has_many :events
  belongs_to :user
end
