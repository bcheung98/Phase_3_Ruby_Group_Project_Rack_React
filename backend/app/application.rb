class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/test/) 
      return [200, { "Content-Type" => "application/json" }, [ {:message => "test response!"}.to_json ]]

    elsif req.path.match(/users/) && req.post?
      data = JSON.parse req.body.read
      #register: data.size = 4, #login: data.size = 3
      if data.size === 4
        student_usernames = Student.all.map {|s| s.username}
        student_emails = Student.all.map {|s| s.email}
        if !student_usernames.include?(data["username"]) 
          if !student_emails.include?(data["email"])
            Student.create(data)
            return [200, { "Content-Type" => "application/json" }, [ {:message => "Successfully registered!"}.to_json ]]
          else
            return [400, { 'Content-Type' => 'application/json' }, [ {:message => "ERROR: That email has already been registered"}.to_json ]] 
          end
        else
          return [400, { 'Content-Type' => 'application/json' }, [ {:message => "ERROR: That username has already been registered"}.to_json ]] 
        end
        return [200, { "Content-Type" => "application/json" }, [ data.to_json ]]
      elsif data.size === 3
        student_usernames = Student.all.map {|s| s.username}
        if student_usernames.include?(data["username"]) 
          current_student = Student.find_by(username: data["username"])
          if current_student.password === data["password"]
            return [200, { "Content-Type" => "application/json" }, [ {:name => data["name"], :courses => current_student.courses.map {|c| 
              {:id => c.id, :subject => c.subject, :number => c.number, :title => c.title, :time => c.time, :teacher => c.teacher.name}
              }}.to_json ]]
          else
            return [400, { 'Content-Type' => 'application/json' }, [ {:message => "Incorrect password"}.to_json ]] 
          end
        else
          return [400, { 'Content-Type' => 'application/json' }, [ {:message => "Username does not exist"}.to_json ]] 
        end
      end 

    elsif req.path.match(/my_courses/) && req.post?
      data = JSON.parse req.body.read
      student = Student.find_by(username: data["user"])
      msg = student.add_course(data["course"]["id"])
      if msg == "Course added successfully!"
        return [200, { "Content-Type" => "application/json" }, [ msg.to_json ]]
      else
        return [400, { "Content-Type" => "application/json" }, [ msg.to_json ]]
      end

    elsif req.path.match(/my_courses/) && req.delete?
      data = JSON.parse req.body.read
      course_id = req.path.split("/").last
      student = Student.find_by(username: data["user"])
      student.drop_course(course_id)
      return [200, { 'Content-Type' => 'application/json' }, [ {:message => "Course dropped!"}.to_json ]] 

    elsif req.path.match(/courses/) && req.get?
      return [200, { "Content-Type" => "application/json" }, [ Course.all.map {|c| {
        id: c.id, 
        subject: c.subject, 
        number: c.number, 
        title: c.title, 
        time: c.time,
        units: c.units,
        teacher: c.teacher.name
      }}.to_json ]]

    else
      resp.write "Path Not Found"

    end

    resp.finish
  end

end
