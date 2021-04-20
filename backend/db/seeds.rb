puts "Clearing old data..."
Enrollment.destroy_all
Student.destroy_all
Course.destroy_all
Teacher.destroy_all

puts "Seeding students..."
40.times do
    Student.create(name: Faker::Name.name)
end

puts "Seeding teachers..."
bill_nye = Teacher.create(name: "Bill Nye")
neil_tyson = Teacher.create(name: "Neil deGrasse Tyson")
ben_stein = Teacher.create(name: "Ben Stein")
dewey_finn = Teacher.create(name: "Dewey Finn")
alan_turing = Teacher.create(name: "Alan Turing")
dennis_ritchie = Teacher.create(name: "Dennis Ritchie")

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

csc101 = Course.create(
    subject: "CSC",
    number: 101,
    title: "Introduction to Computer Programming",
    time: "M-W-F 13:00-13:50",
    units: 4,
    teacher_id: alan_turing.id
)

csc335 = Course.create(
    subject: "CSC",
    number: 335,
    title: "Introduction to C",
    time: "T-Th 11:00-12:15",
    units: 4,
    teacher_id: dennis_ritchie.id
)

puts "Enrolling students..."
10.times do
    Student.all.each {|s| s.add_course(Course.all.sample.id)}
end

puts "Done!"
