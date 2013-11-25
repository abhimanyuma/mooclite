class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.string :offered_by
      t.string :bio

      t.timestamps
    end
  end
end
