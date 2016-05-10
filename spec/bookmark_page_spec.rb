require 'bookmark_page'

RSpec::Matchers.define :precede do |expected, ary|
  match do |actual|
    ary.index(expected) > ary.index(actual)
  end
end

RSpec.describe 'BookmarkPage' do
  context '#new' do
    before :each do
      @fname = 'testdata/one.html'
    end

    it 'exists' do
      expect(@b = BookmarkPage.new)
    end

    it 'loads a file if given' do
      expect(BookmarkPage.new(file: @fname).data[0..4]).to eq 'hello'
    end

    it 'loads assets if given' do
      @b = BookmarkPage.new(assets_dir: 'testdata/assets')
      expect(@b.css.sort).to eq ['testdata/assets/css/style1.css',
                                 'testdata/assets/style2.css']
      expect(@b.js.sort).to eq ['testdata/assets/js/script2.js',
                                'testdata/assets/script1.js']
    end
  end

  context '#read' do
    before :each do
      @b = BookmarkPage.new
    end

    it 'exists' do
      expect(@b.read('testdata/one.html'))
    end

    it 'updates data' do
      @b.read 'testdata/one.html'
      expect(@b.data[0..4]).to eq('hello')
    end

    it 'raises "File not found: {filename}" if no such file' do
      expect { @b.read('nofile') }.to raise_error('File not found: nofile')
    end
  end

  context '#load_assets' do
    before :each do
      @b = BookmarkPage.new
    end

    it 'exists' do
      expect(@b.load_assets('testdata/assets'))
    end

    it 'loads assets' do
      @b.load_assets 'testdata/assets'
      expect(@b.css.sort).to eq(['testdata/assets/css/style1.css',
                                 'testdata/assets/style2.css'])
      expect(@b.js.sort).to eq(['testdata/assets/js/script2.js',
                                'testdata/assets/script1.js'])
    end

    it 'raises "Dir not found: {assets_dir}" if no such dir' do
      expect { @b.load_assets('nodir') }.to raise_error('Dir not found: nodir')
    end
  end

  context '#parse' do
    before :all do
      @b = BookmarkPage.new(file: 'testdata/two.html',
                            assets_dir: 'testdata/assets')
      f = File.open('testdata/parse_output.html', 'rb')
      @out = f.read
      @out_lines = @out.split("\n")
      @subject = @b.parse
      @subject_lines = @subject.split("\n")
      @link_1 = %(    <link rel="stylesheet" href="testdata/assets/css/style1.css">)
      @link_2 = %(    <link rel="stylesheet" href="testdata/assets/style2.css">)
      @script_1 = %(    <script type="text/javascript" src="testdata/assets/script1.js"></script>)
      @script_2 = %(    <script type="text/javascript" src="testdata/assets/js/script2.js"></script>)

    end

    it 'exists' do
      expect(@b.parse)
    end

    it 'writes a doctype tag' do
      expect(@subject_lines[0]).to eq('<!DOCTYPE html>')
    end

    it 'writes a head element' do
      expect(@subject_lines).to include('  <head>')
      expect(@subject_lines).to include('  </head>')
      expect('  <head>').to precede('  </head>', @subject_lines)
    end

    it 'links stylesheets' do
      expect(@subject_lines).to include(@link_1)
      expect(@subject_lines).to include(@link_2)
      expect('  <head>').to precede(@link_1, @subject_lines)
      expect(@link_1).to precede('  </head>', @subject_lines)
    end

    it 'adds scripts' do
      expect(@subject_lines).to include(@script_1)
      expect(@subject_lines).to include(@script_2)
      expect('  <body>').to precede(@script_1, @subject_lines)
      expect(@script_1).to precede('  </body>', @subject_lines)
    end
  end
end
