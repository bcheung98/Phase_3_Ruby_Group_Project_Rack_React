require "nokogiri"
require "open-uri"
require "pry"

def scrape()

    doc = Nokogiri::HTML(URI.open("http://catalog.collegeofsanmateo.edu/current/courses/"))

    subjects = []
    doc.css(".list-style-angle-right.list-size-lg")[0].children.each {|i| 
        temp = []
        if i.text.strip != ""
            i.text.split("(")[0].strip.split(" ").each {|word|
                if word != "-" && word != "–"
                    temp << word
                end
            }
            subjects << temp.join("-")
        end
    }

    class_hash = {}
    subjects.each {|subject|
        classes = []
        one_class = []
        if subject != "Kinesiology,-Athletics,-and-Dance"
            Nokogiri::HTML(URI.open("http://catalog.collegeofsanmateo.edu/current/courses/#{subject}/"))
            .css(".table.table-hover.table-striped.smc-catalog-course-listings")[0].children[5].children.children.text.strip.split("\n").each {|i|
            if i.strip != ""
                one_class << i.strip
            else
                one_class[2] = one_class[2].split(" ")[0]
                classes << one_class
                one_class = []
            end
        }
        end
        class_hash[subject] = classes
    }
    class_hash

end

#binding.pry