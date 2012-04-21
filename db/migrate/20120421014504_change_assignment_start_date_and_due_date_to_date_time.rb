class ChangeAssignmentStartDateAndDueDateToDateTime < ActiveRecord::Migration
  def up
    change_column :assignments, :due_date, :datetime
    change_column :assignments, :start_date, :datetime
  end

  def down
    change_column :assignments, :due_date, :string
    change_column :assignments, :start_date, :string
  end
end
