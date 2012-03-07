class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :email
      t.string :office_hours
      t.string :phone
      t.string :type

      t.timestamps
    end
  end
end
