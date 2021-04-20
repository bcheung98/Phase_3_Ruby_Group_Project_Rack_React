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
