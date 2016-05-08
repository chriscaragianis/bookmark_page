require 'BookmarkParse'

class BookmarkPage

  include BookmarkParse
  attr_accessor :data

  def initialize(params = {})
    params.each { |key,value| instance_variable_set("@#{key}", value) }
    if params[:file] then
      read(params[:file])
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

  def write
  end
end
