class ChangePublishedDefaultValue < ActiveRecord::Migration
  def up
    change_column_default(:courses, :published, false)
  end

  def down
    change_column_default(:courses, :published, nil)
  end
end
