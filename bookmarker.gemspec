Gem::Specification.new do |s|
  s.name      = 'bookmarker'
  s.version   = '0.0.1'
  s.date      = '2016-05-13'
  s.summary   = 'Bookmarker creates nice looking web pages from bookmarks exported from your browser'
  s.authors   = ['Chris Caragianis']
  s.email     = 'chriscaragianis@gmail.com'
  s.files     = ['lib/bookmark_parse.rb',
                 'lib/bookmarker.rb',
                 'lib/out.html.erb',
                 'spec/bookmarker_spec.rb',
                 'spec/bookmark_parse_spec.rb',
                 'bookmarks.html',
                 'testdata/one.html',
                 'testdata/assets/script1.js',
                 'testdata/assets/js/script2.js',
                 'testdata/assets/style2.css',
                 'testdata/assets/css/style1.css',
                 'testdata/bookmarks.html',
                 'testdata/assets/js/jquery.js']
  s.homepage  = 'https://github.com/chriscaragianis/bookmarker'
  s.license   = 'MIT'
end
