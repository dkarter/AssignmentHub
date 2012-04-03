class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.integer :id
      t.string :name
      t.string :city
      t.string :state
      t.string :website

      t.timestamps
    end
  end
end
