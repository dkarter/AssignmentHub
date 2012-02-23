class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.string :type
      t.string :start_date
      t.string :due_date
      t.tinyint :priority
      t.string :notes

      t.timestamps
    end
  end
end
