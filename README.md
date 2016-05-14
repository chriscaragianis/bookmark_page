#Bookmarker

A gem for making nice webpages out of bookmarks exported from
your browser.

##Installation

```zsh
$ gem install bookmarker
```

then

```ruby
require 'bookmarker'
```

##Usage

```ruby
bmarks = Bookmarker.new(options)
```

where

```ruby
options = { file: 'path/to/exported_bookmarks.html',
            assets_dir: 'root/dir/for/js_and_css',
            link_class: 'class attribute for links',
            folder_class: 'class attribute for <ul>',
            folder_head_class: 'class attribute for folder headings'
          }
```

default values

```ruby
file: 'bookmarks.html',
assets_dir: '.',
link_class: 'link',
folder_class: 'folder',
folder_head_class: 'folder-head'
```

change file

```ruby
bmarks.read('new_bookmarks.html')
```

change assets dir

```ruby
bmarks.load_assets('new_dir')
```

produce output

```ruby
html_out = bmarks.parse
```
