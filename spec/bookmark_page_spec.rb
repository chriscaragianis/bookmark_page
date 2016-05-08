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
end
