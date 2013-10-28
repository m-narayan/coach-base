class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :id
      t.integer :activity_object_id

      t.timestamps
    end
  end
end
