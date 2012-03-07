class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.string :type
      t.string :start_date
      t.string :due_date
      t.integer :priority
      t.text :notes

      t.timestamps
    end
  end
end
