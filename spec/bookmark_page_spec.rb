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
      expect(BookmarkPage.new(file: "testdata/one.html").data)
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

<<<<<<< HEAD
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
=======
  context "#write" do
    before :each do
      @b = BookmarkPage.new(file: "testdata/two.html")
    end

    it "exists" do
      expect(@b.write)
>>>>>>> 10839a3d802064c89e703e3bd4c5506ee3c99778
    end
  end
end
