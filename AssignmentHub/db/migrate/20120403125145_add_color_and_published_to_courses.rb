class AddColorAndPublishedToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :color, :string

    add_column :courses, :published, :boolean, :default => 0

  end
end
