require 'BookmarkParse'

class BookmarkPage

  include BookmarkParse
  attr_accessor :data, :css, :js

  def initialize(params = {})
    params.each { |key,value| instance_variable_set("@#{key}", value) }
    if params[:file] then
      read(params[:file])
    end
    if params[:assets_dir] then
      @css = Dir.glob("#{params[:assets_dir]}/**/*.css")
      @js = Dir.glob("#{params[:assets_dir]}/**/*.js")
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
    @css = Dir.glob("assets_dir/**/*.css")
    @js = Dir.glob("assets_dir/**/*.js")
  end

  def parse
    "<!DOCTYPE html>\n  <head>\n  </head>"
  end
end
