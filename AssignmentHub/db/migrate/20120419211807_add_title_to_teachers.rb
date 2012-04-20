class AddTitleToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :title, :integer

  end
end
