def make_head
  out = "<!DOCTYPE html>\n\n  <head>\n"
  Dir.foreach("stylesheets") do |fname|
    if fname.slice(-4, 4) == ".css" then
      out << "    <link rel=\"stylesheets\" href=\"stylesheets/#{fname}\">\n"
    end
  end
  out << "  </head>"
  out
end

