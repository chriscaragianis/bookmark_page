require 'bookmarker'

RSpec.describe "get_tag_content" do

  it "exists" do
    expect(get_tag_content "")
  end

  it "gets the content of a flat tag" do
    expect(get_tag_content "<tag>text</tag>").to eq("text")
  end

  it "gets the content of a tag with nesting" do
    expect(get_tag_content "<a>HI<s>BYE!</s></a>").to eq("HI<s>BYE!</s>")
  end

  it "ignores trailing tags" do
    expect(get_tag_content "<a>HI<s>BYE!</s></a><a></a>").to eq("HI<s>BYE!</s>")
  end

  it "it chains predictably" do
    str = get_tag_content("<a>HI<s>BYE!</s></a><a></a>")
    expect(get_tag_content(str)).to eq("BYE!")
  end
end


