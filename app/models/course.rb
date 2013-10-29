class Course < ActiveRecord::Base
  include SocialStream::Models::Object
    has_attached_file :course_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_many :events
  belongs_to :user
end
