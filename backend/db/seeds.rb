puts "Clearing old data..."
Enrollment.destroy_all
Student.destroy_all
Course.destroy_all
Teacher.destroy_all

puts "Seeding students..."
20.times do
    Student.create(name: Faker::Name.name)
end

puts "Seeding teachers..."
bill_nye = Teacher.create(name: "Bill Nye")
neil_tyson = Teacher.create(name: "Neil deGrasse Tyson")
ben_stein = Teacher.create(name: "Ben Stein")
dewey_finn = Teacher.create(name: "Dewey Finn")

puts "Seeding courses..."
phys101 = Course.create(
    subject: "PHYS",
    number: 101,
    title: "Introduction to Physics",
    time: "M-W-F 10:00-10:50",
    units: 3,
    teacher_id: bill_nye.id
)
astr101 = Course.create(
    subject: "ASTR",
    number: 101,
    title: "Introduction to Planetary Science",
    time: "T-Th 14:00-15:15",
    units: 3,
    teacher_id: neil_tyson.id
)
econ101 = Course.create(
    subject: "ECON",
    number: 101,
    title: "Introduction to Economics",
    time: "M-W-F 8:00-8:50",
    units: 3,
    teacher_id: ben_stein.id
)
mus101 = Course.create(
    subject: "MUS",
    number: 101,
    title: "Introduction to Music Theory",
    time: "M-W-F 10:00-10:50",
    units: 3,
    teacher_id: dewey_finn.id
)

puts "Enrolling students..."
3.times do
    Student.all.each {|s| s.add_course(Course.all.sample.id)}
end

puts "Done!"
