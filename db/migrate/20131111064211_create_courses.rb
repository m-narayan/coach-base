class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer  :actor_id
      t.decimal  :price
      t.timestamps
    end
  end
end
