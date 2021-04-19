class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :subject
      t.integer :number
      t.string :title
      t.string :time
      t.belongs_to :teacher
    end
  end
end
