require 'bookmark_parse'

# :nodoc:
class BookmarkPage
  include BookmarkParse
  attr_accessor :data, :css, :js

  def initialize(params = {})
    params.each { |key, value| instance_variable_set("@#{key}", value) }
    read params[:file] if params[:file]
    load_assets params[:assets_dir] if params[:assets_dir]
  end

  def read(filename)
    raise "File not found: #{filename}" unless File.exist?(filename)
    f = File.open(filename, 'rb')
    @data = f.read
    @data_lines = @data.split("\n")
  end

  def load_assets(assets_dir)
    raise "Dir not found: #{assets_dir}" unless File.directory? assets_dir
    @css = Dir.glob "#{assets_dir}/**/*.css"
    @js = Dir.glob "#{assets_dir}/**/*.js"
  end

  def parse
    out = "<!DOCTYPE html>\n  <head>\n"
    @css.each do |f|
      out << %(    <link rel="stylesheet" href="#{f}">\n)
    end
    out << "  </head>\n"
    out << "  <body>\n"
    @data_lines.each do |l|
      out << "<ul>\n" if l.include?('<DL')
      out << %(<a href=""></a>\n) if l.include?('<A HREF')
    end
    @js.each do |f|
      out << %(    <script type="text/javascript" src="#{f}"></script>\n)
    end
    out << "  </body>\n"
  end
end
