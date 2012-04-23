class AddNotificationTypeToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :notification_type, :string
  end
end
