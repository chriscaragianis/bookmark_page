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

def make_body input
  spaces = "    "
  open_tags = tag_hash ["ul", "a", "li"]
  lines = input.split("\n")
  out = "  <body>\n"
  lines.each do |l|
    if l.include? "<DL>" then
      out << "<ul>\n"
    end
    if l.include? "</DL" then
      out << "</ul>\n"
    end
    if l.include? "<A HREF" then
      out << "<li>\n"
      out << "<a href>\n"
      out << "</a>\n"
      out << "</li>\n"
    end
  end
  open_tags.keys.each do |tag|
    if open_tags[tag] then
      out << "</#{tag}>\n"
    end
  end

  Dir.foreach("src") do |fname|
    if fname.slice(-3, 3) == ".js" then
      out << "    <script type=\"text/javascript\" src=\"src/#{fname}\"></script>\n"
    end
  end
  out << "  </body>"
  out
end

def tag_hash tag_list
  out = Hash.new
  tag_list.each do |a|
    out[a] = false
  end
  out
end


