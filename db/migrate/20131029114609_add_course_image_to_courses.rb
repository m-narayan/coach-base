class AddCourseImageToCourses < ActiveRecord::Migration
  def change
    add_attachment :courses, :course_image
  end
end
