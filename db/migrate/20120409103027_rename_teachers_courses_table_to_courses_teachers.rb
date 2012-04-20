class RenameTeachersCoursesTableToCoursesTeachers < ActiveRecord::Migration
  def up
    rename_table :teachers_courses, :courses_teachers
  end

  def down
    rename_table :courses_teachers, :teachers_courses 
  end
end
