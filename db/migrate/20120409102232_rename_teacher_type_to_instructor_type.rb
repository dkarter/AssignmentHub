class RenameTeacherTypeToInstructorType < ActiveRecord::Migration
  def up
    rename_column :teachers, :type, :instructor_type
  end

  def down
    rename_column :teachers, :instructor_type, :type
  end
end
