class AddFirstToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :first, :string

  end
end
