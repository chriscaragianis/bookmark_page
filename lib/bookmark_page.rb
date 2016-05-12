require 'bookmark_parse'
require 'erb'

# :nodoc:
class BookmarkPage
  include BookmarkParse
  attr_accessor :data, :css, :js, :bookmarks

  def initialize(params = {})
    params.each { |key, value| instance_variable_set("@#{key}", value) }
    read params[:file] if params[:file]
    load_assets params[:assets_dir] if params[:assets_dir]
    @bookmarks = []
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
    @data_lines.each do |l|
      @bookmarks << [get_link_href(l), get_tag_content(l)] if l.include? 'HREF'
      @bookmarks << 'UL' if l.include?('<DL>')
    end
    template_file = File.open('lib/out.html.erb', 'rb')
    template = template_file.read
    renderer = ERB.new(template)
    renderer.result(binding)
  end
end
