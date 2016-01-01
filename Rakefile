# Rake tasks to parse haml layouts, includes and index files and sass files for jekyll
# Assumes that the haml files are in (_layouts|_includes)/_haml
# and the sass files are in css/_sass
#
namespace :haml do
  require 'haml'

  def convert file, destination
    base_name = File.basename(file, '.haml') + '.html'
    html = File.open(file, 'r') { |f| Haml::Engine.new(f.read).render }
    File.open(File.join(destination, base_name), 'w') { |f| f.write html }
  end

  desc 'Parse haml layout files'
  task :layouts do
    Dir.glob('_layouts/_haml/*.haml') do |path|
      convert path, '_layouts'
      puts "converting #{path}"
    end

    puts 'Parsed haml layout files'
  end

  desc 'Parse haml include files'
  task :includes do
    Dir.glob('_includes/_haml/*.haml') do |path|
      convert path, '_includes'
      puts "converting #{path}"
    end

    puts 'Parsed haml include files'
  end

  desc 'Parse haml index files'
  task :indexes do
    Dir.glob('**/index.haml') do |path|
      convert path, File.dirname(path).split('/').first
      puts "converting #{path}"
    end

    puts 'Parsed haml index files'
  end

end

desc 'Parse all haml items'
task haml: ['haml:layouts', 'haml:includes', 'haml:indexes']

desc 'Compile files, commit and deploy to gh-pages'
task :deploy do
  # precompile for production
  Rake::Task["haml"].execute

  # run jekyll command to generate site folder
  `bundle exec jekyll build`

  # copy the _site folder in a tmp folder outside the repo
  `mkdir ~/jekylltmp`
  `cp -r _site/* ~/jekylltmp/`

  # add the image assets (for some reason jekyll-assets doesn't include this automatically)
  # `cp -r _assets/images/ ~/jekylltmp/assets/`

  # switch to gh-pages branch
  `git checkout gh-pages`

  # copy contents of _site to gh-pages root (with overrides)
  `yes | cp -rfv ~/jekylltmp/* .`

  # add nojekyll file
  # `touch .nojekyll`

  # git add + commit
  system "git add ."
  system "git commit"

  # delete the tmp folder from jekyll
  `rm -r ~/jekylltmp`
end

