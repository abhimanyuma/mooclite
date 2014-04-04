class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :title
      t.integer :instructor_id
      t.text :content
      t.date :date
      t.string :overview
      t.integer :course_id
      t.integer :lecture_no

      t.timestamps
    end

    add_index :lectures, :course_id
    add_index :lectures, [:course_id,:lecture_no]
    add_index :lectures, :date
  end
end
