require "BookmarkParse"

RSpec.describe "BookmarkParse" do

  let(:d) { Class.new { include BookmarkParse } }

  context "#get_tag_content" do
    subject { d.new }
    it "gets the content of a flat tag" do
      expect(subject.get_tag_content "<tag>text</tag>").to eq("text")
    end

    it "gets the content of a tag with nesting" do
      expect(subject.get_tag_content "<a>HI<s>BYE!</s></a>").to eq("HI<s>BYE!</s>")
    end

    it "ignores trailing tags" do
      expect(subject.get_tag_content "<a>HI<s>BYE!</s></a><a></a>").to eq("HI<s>BYE!</s>")
    end

    it "it chains predictably" do
      str = subject.get_tag_content("<a>HI<s>BYE!</s></a><a></a>")
      expect(subject.get_tag_content(str)).to eq("BYE!")
    end
  end

  context "get_link_href" do
    subject { d.new }

    it "exists" do
      expect(subject.get_link_href "")
    end

    it "returns the address of a link" do
      expect(subject.get_link_href "<a href='address'>af</a>").to eq("address")
      expect(subject.get_link_href "<a href=\"address\">af</a>").to eq("address")
      expect(subject.get_link_href "<a hReF='address'>af</a>").to eq("address")
    end
  end

end

