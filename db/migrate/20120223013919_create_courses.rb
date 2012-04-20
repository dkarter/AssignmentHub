class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :course_number
      t.string :school
      t.string :section
      t.string :code
      
      
      t.timestamps
    end
  end
end
