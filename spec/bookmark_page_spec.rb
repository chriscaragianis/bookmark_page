require "BookmarkPage"

RSpec.describe "BookmarkPage" do

  context "#new" do
    before :each do
      @b = BookmarkPage.new
    end

    it "exists" do
      expect(@b)
    end
  end
end
