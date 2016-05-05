require 'bookmarker'

RSpec.describe "make_body" do
  before :all do
    file = File.open("bookmarks.html", "rb")
    contents = file.read
    @lines = make_body(contents).split("\n")
    @open_tag_hash = tag_hasher @lines, ["<ul", "<li", "<a"]
    @close_tag_hash = tag_hasher @lines, ["</ul>", "</li>", "</a>"]
    @close_tags = @close_tag_hash.keys
  end

  after :all do
    file = File.open("bookmarks.html", "rb")
    contents = file.read
    puts make_head
    puts make_body(contents)
  end

  describe "make_body constructs the body element" do
    it "begins with the body tag" do
      expect(@lines[0]).to eq("  <body>")
    end

    it "closes the body tag" do
      expect(@lines[-1]).to eq("  </body>")
    end

    it "includes the users javascripts" do
      expect(@lines[-3]).to eq("    <script type=\"text/javascript\" src=\"src/bmscript1.js\"></script>")
      expect(@lines[-2]).to eq("    <script type=\"text/javascript\" src=\"src/bmscript2.js\"></script>")
    end

    it "creates an unordered list for each folder" do
     expect(@lines.select {|a| a.strip.slice(0, 3) == "<ul"}.length).to eq(2)
    end

    it "closes all tags" do
      @open_tag_hash.keys.each_with_index do |tag, i|
        expect(@open_tag_hash[tag].length).to eq(@close_tag_hash[@close_tags[i]].length)
      end
    end

    it "creates <a> tag for each bookmark" do
      expect(@lines.select {|a| a.strip.slice(0,7) == "<a href"}.length).to eq(3)
    end

  end

    it "nests <a> tags in <li> tags" do
      safe = false
      @lines.each do |l|
        if l.include?("<a href") && !safe then
          fail
        end
        if l.include?("<li") then
          safe = true
        end
        if l.include?("</li>") then
          safe = false
        end
      end
    end

    it "nests <li> tags in <ul> tags" do
      safe = false
      @lines.each do |l|
        if l.include?("<li") && !safe then
          fail
        end
        if l.include?("<ul") then
          safe = true
        end
        if l.include?("</ul>") then
          safe = false
        end
      end
    end

  def tag_hasher ary, tag_list
    out = Hash.new
    tag_list.each do |tag|
      out[tag] = ary.select {|a| a.include? tag}
    end
    out
  end

end
