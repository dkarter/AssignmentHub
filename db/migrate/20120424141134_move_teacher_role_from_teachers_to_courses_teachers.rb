class MoveTeacherRoleFromTeachersToCoursesTeachers < ActiveRecord::Migration
  def up
    add_column :courses_teachers, :role, :integer
    remove_column :teachers, :role
  end

  def down
    remove_column :courses_teachers, :role
    add_column :teachers, :role, :string
  end
end
