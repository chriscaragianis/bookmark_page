require 'BookmarkParse'

class BookmarkPage

  include BookmarkParse
  attr_accessor :data, :css, :js

  def initialize(params = {})
    params.each { |key,value| instance_variable_set("@#{key}", value) }
    if params[:file] then
      read params[:file]
    end
    if params[:assets_dir] then
      load_assets params[:assets_dir]
    end
  end

  def read filename
    if File.exist?(filename) then
      f = File.open(filename, 'rb')
      @data = f.read
    else
      raise "File not found: #{filename}"
    end
  end

  def load_assets assets_dir
    if File.directory? assets_dir then
      @css = Dir.glob("#{assets_dir}/**/*.css")
      @js = Dir.glob("#{assets_dir}/**/*.js")
    else
      raise ("Dir not found: #{assets_dir}")
    end
  end

  def parse
    out = "<!DOCTYPE html>\n  <head>\n"
    @css.each do |f|
      out << %Q[    <link rel="stylesheet" href="#{f}">\n]
    end
    out << "  </head>"
    out
  end
end
