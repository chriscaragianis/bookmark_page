require 'bookmarker'

RSpec.describe "get_link_href" do

  it "exists" do
    expect(get_link_href "")
  end

  it "returns the address of a link" do
    expect(get_link_href "<a href='address'>af</a>").to eq("address")
    expect(get_link_href "<a href=\"address\">af</a>").to eq("address")
    expect(get_link_href "<a hReF='address'>af</a>").to eq("address")
  end

end
