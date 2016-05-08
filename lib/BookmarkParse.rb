module BookmarkParse

  def get_tag_content str
    str.match(/>([^<]*|(<\w*>[^<]*<\/\w*>))*<\//).to_s[1..-3]
  end

  def get_link_href str
    str.match(/href=("|')[^("|')]*/i).to_s[6..-1]
  end

end
