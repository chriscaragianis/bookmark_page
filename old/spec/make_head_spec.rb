require 'bookmarker'

RSpec.describe "make_head" do
  before :each do
    @lines = make_head().split("\n")
  end

  it "runs" do
    expect(make_head())
  end

  it "creates a doctype" do
    expect(@lines[0]).to eq("<!DOCTYPE html>")
  end

  it "creates an open head tag" do
    expect(@lines[1]).to eq("")
    expect(@lines[2]).to eq("  <head>")
  end

  it "links user stylesheets" do
    expect(@lines[3]).to eq("    <link rel=\"stylesheets\" href=\"stylesheets/bmstyle1.css\">")
    expect(@lines[4]).to eq("    <link rel=\"stylesheets\" href=\"stylesheets/bmstyle2.css\">")
  end

  it "closes the head tag" do
    expect(@lines[-1]).to eq("  </head>")
  end
end
