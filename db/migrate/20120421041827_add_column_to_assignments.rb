class AddColumnToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :all_day, :boolean

  end
end
