class ChangeTypeToAssignmentType < ActiveRecord::Migration
  def change
    rename_column :assignments, :type, :assignment_type
  end
end
