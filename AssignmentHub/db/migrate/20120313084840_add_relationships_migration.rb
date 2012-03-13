class AddRelationshipsMigration < ActiveRecord::Migration
  def up
    # courses
    add_column :courses, :user_id, :integer
 
    # assignments
    add_column :assignments, :course_id, :integer
    
    # attachments
    add_column :attachments, :course_id, :integer
    add_column :attachments, :assignment_id, :integer
    
    # for many to many - teachers to courses
    create_table :teachers_courses, :id => false do |t|
      t.integer :teacher_id
      t.integer :course_id
    end

  end

  def down
    # courses
    remove_column :courses, :user_id
 
    # assignments
    remove_column :assignments, :course_id
    
    # attachments
    remove_column :attachments, :course_id
    remove_column :attachments, :assignment_id
    
    # for many to many - teachers to courses
    drop_table :teachers_courses
  end
end
