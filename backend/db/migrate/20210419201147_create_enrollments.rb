class CreateEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollments do |t|
      t.belongs_to :student
      t.belongs_to :course
    end
  end
end
