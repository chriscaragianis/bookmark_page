require 'BookmarkParse'

class BookmarkPage

  include BookmarkParse
  attr_accessor :data

  def initialize(params = {})
    params.each { |key,value| instance_variable_set("@#{key}", value) }
    if @file then
      f = File.open(@file, 'rb')
      @data = f.read
    end
  end

  def parse_export str
  end
end
