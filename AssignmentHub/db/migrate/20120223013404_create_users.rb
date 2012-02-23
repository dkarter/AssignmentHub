class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :first
      t.string :last
      t.string :email
      t.string :phone
      t.integer :user_type

      t.timestamps
    end
  end
end
