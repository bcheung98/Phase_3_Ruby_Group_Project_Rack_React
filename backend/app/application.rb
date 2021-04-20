class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/test/) 
      return [200, { "Content-Type" => "application/json" }, [ {:message => "test response!"}.to_json ]]

    elsif req.path.match(/my_courses/) && req.get?
      return [200, { "Content-Type" => "application/json" }, [ Student.first.courses.map {|c| {
        id: c.id, 
        subject: c.subject, 
        number: c.number, 
        title: c.title, 
        time: c.time,
        units: c.units,
        teacher: c.teacher.name
      }}.to_json ]]

    elsif req.path.match(/my_courses/) && req.post?
      data = JSON.parse req.body.read
      # TODO: Implement login system for different students/users
      msg = Student.first.add_course(data["id"])
      if msg == "Course added successfully!"
        return [200, { "Content-Type" => "application/json" }, [ msg.to_json ]]
      else
        return [400, { "Content-Type" => "application/json" }, [ msg.to_json ]]
      end

    elsif req.path.match(/my_courses/) && req.delete?
      course_id = req.path.split("/").last
      Student.first.drop_course(course_id)
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
