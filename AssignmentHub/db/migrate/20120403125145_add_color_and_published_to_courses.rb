class AddColorAndPublishedToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :color, :string

    add_column :courses, :published, :boolean

  end
end
