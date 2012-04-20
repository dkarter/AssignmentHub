class FixColumnName < ActiveRecord::Migration
  def change
      rename_column :teachers, :name, :last
    end
end
