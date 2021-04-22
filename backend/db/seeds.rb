require "open-uri"

def seed_students()
    Student.destroy_all
    puts "Seeding students..."
    1000.times do
        name = Faker::Name.name
        Student.create(name: name, username: name.split(" ").join(""), email: "#{name.split(" ").join("")}@email.com", password: rand(100000..999999).to_s)
    end
end

def seed_teachers()
    Teacher.destroy_all
    puts "Seeding teachers..."
    200.times do
        Teacher.create(name: Faker::Name.name)
    end
end

def seed_courses()
    times = ["M-W-F 8:00-8:50", 
            "M-W-F 9:00-9:50", 
            "M-W-F 10:00-10:50", 
            "M-W-F 11:00-11:50", 
            "M-W-F 12:00-12:50", 
            "M-W-F 13:00-13:50", 
            "M-W-F 14:00-14:50", 
            "M-W-F 15:00-15:50", 
            "M-W-F 16:00-16:50", 
            "M-W-F 17:00-17:50", 
            "T-Th 8:00-9:15", 
            "T-Th 9:30-10:45", 
            "T-Th 11:00-12:15", 
            "T-Th 12:30-13:45", 
            "T-Th 14:00-15:15", 
            "T-Th 15:30-16:45", 
            "T-Th 17:00-18:15", 
            "T-Th 18:30-19:45"]
    Course.destroy_all
    puts "Seeding courses..."
    courses = scrape()
    courses.each {|k, v| v.each {|c| Course.create(
        subject: c[0].split[0], 
        number: c[0].split[1], 
        title: c[1], 
        time: times.sample, 
        units: c[2],
        teacher_id: Teacher.all.sample.id
    )}}
end

def seed_enrollments()
    Enrollment.destroy_all
    puts "Enrolling students..."
    6.times do
        Student.all.each {|s| s.add_course(Course.all.sample.id)}
    end
end

seed_students()
seed_teachers()
seed_courses()
seed_enrollments()

puts "Done!"
