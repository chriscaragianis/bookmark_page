# :nodoc:
module BookmarkParse
  def get_tag_content(str)
    str[%r{>([^<]*|(<\w*>[^<]*</\w*>))*<\/}][1..-3]
  end

  def get_link_href(str)
    str[/href=("|')[^("|')]*/i][6..-1]
  end
end
