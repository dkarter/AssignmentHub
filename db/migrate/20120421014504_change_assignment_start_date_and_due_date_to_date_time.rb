class ChangeAssignmentStartDateAndDueDateToDateTime < ActiveRecord::Migration
  def up
    remove_column :assignments, :due_date
    add_column :assignments, :due_date, :datetime
    remove_column :assignments, :start_date
    add_column :assignments, :start_date, :datetime
  end

  def down
    remove_column :assignments, :due_date
    add_column :assignments, :due_date, :string
    remove_column :assignments, :start_date
    add_column :assignments, :start_date, :string
  end
end
