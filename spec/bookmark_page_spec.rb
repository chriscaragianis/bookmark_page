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
end
