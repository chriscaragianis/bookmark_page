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
    @folder_class ||= 'folder'
    @folder_head_class ||= 'folder-head'
    @link_class ||= 'link'
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
    depth = 0
    @data_lines.each do |l|
      if l.include?('<DT>')
        if l.include? 'HREF'
          @bookmarks << [get_link_href(l), get_tag_content(l)]
        else
          @bookmarks << ['HEADING', depth, get_tag_content(l)]
        end
      end
      if l.include?('<DL>')
        @bookmarks << 'UL'
        depth += 1
      end
      if l.include?('</DL>')
        @bookmarks << '/UL'
        depth -= 1
      end
    end
    template_file = File.open('lib/out.html.erb', 'rb')
    template = template_file.read
    renderer = ERB.new(template)
    renderer.result(binding)
  end
end
