class Course < ActiveRecord::Base
    belongs_to :teacher
    has_many :enrollments
    has_many :students, through: :enrollments

    def enroll_student(student_id)
        Enrollment.create(student_id: student_id, course_id: self.id)
    end

end