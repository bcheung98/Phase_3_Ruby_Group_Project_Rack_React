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
      msg = Student.first.add_course(Course.find(data["id"]).id)
      if msg == "Course added successfully!"
        return [200, { "Content-Type" => "application/json" }, [ data.to_json ]]
      else
        resp.write msg
      end

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
