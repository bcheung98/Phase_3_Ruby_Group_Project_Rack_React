class Student < ActiveRecord::Base
    has_many :enrollments
    has_many :courses, through: :enrollments

    def add_course(course_id)
        if !self.courses.include?(Course.find(course_id))
            if !self.courses.map {|c| c.time}.include?(Course.find(course_id).time)
                Enrollment.create(student_id: self.id, course_id: course_id)
            else
                return "You cannot enroll in this course because of a time conflict!"
            end
        else
            return "You are already enrolled in that course!"
        end
        "Course added successfully!"
    end

    def drop_course(course_id)
        self.enrollments.find_by(course_id: course_id).destroy
    end

    def total_units()
        self.courses.map {|c| c.units}.sum
    end
    
end