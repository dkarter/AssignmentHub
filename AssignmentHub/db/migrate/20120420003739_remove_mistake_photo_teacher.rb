class RemoveMistakePhotoTeacher < ActiveRecord::Migration
  def change 
    remove_column :teachers, :photo_file_name
    remove_column :teachers, :photo_content_type
    remove_column :teachers, :photo_file_size
  end
end
