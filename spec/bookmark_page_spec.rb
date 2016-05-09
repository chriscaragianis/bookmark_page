require "BookmarkPage"

RSpec.describe "BookmarkPage" do

  context "#new" do
    before :each do
      @b = BookmarkPage.new
    end

    it "exists" do
      expect(@b)
    end

    it "loads a file if given" do
      expect(BookmarkPage.new(file: "testdata/one.html").data[0..4]).to eq("hello")
    end

    it "loads assets if given" do
      @b = BookmarkPage.new(assets_dir: "testdata/assets")
      expect(@b.css.sort).to eq(["testdata/assets/css/style1.css", "testdata/assets/style2.css"])
      expect(@b.js.sort).to eq(["testdata/assets/js/script2.js", "testdata/assets/script1.js"])
    end
  end

  context "#read" do
    before :each do
      @b = BookmarkPage.new
    end

    it "exists" do
      expect(@b.read "testdata/one.html")
    end

    it "updates data" do
      @b.read "testdata/one.html"
      expect(@b.data[0..4]).to eq("hello")
    end

    it "raises 'File not found: {filename}' if no such file" do
      expect{@b.read("nofile")}.to raise_error("File not found: nofile")
    end
  end

  context "#load_assets" do
    before :each do
      @b = BookmarkPage.new
    end

    it "exists" do
      expect(@b.load_assets "testdata/assets")
    end

    it "loads assets" do
      @b.load_assets "testdata/assets"
      expect(@b.css.sort).to eq(["testdata/assets/css/style1.css", "testdata/assets/style2.css"])
      expect(@b.js.sort).to eq(["testdata/assets/js/script2.js", "testdata/assets/script1.js"])
    end

    it "raises 'Dir not found: {assets_dir}' if no sudh dir" do
      expect{@b.load_assets("nodir")}.to raise_error("Dir not found: nodir")
    end
  end

  context "#parse" do
    before :all do
      @b = BookmarkPage.new(file: "testdata/two.html")
      f = File.open("testdata/parse_output.html", 'rb')
      @out = f.read
      @out_lines = @out.split("\n")
      @subject = @b.parse
      @subject_lines = @subject.split("\n")
    end

    it "exists" do
      expect(@b.parse)
    end

    it "writes a doctype tag" do
      expect(@subject_lines[0]).to eq("<!DOCTYPE html>")
    end

    it "writes a head element" do
      expect(@subject_lines.include?("  <head>")).to be true
      expect(@subject_lines.include?("  </head>")).to be true
      open = @subject_lines.index("  <head>")
      close = @subject_lines.index("  </head>")
      expect(open).to be < close
    end
  end
end
