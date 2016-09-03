###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
  activate :relative_assets
end

config[:haml] = {ugly: true, format: :html5}

activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.build_before = false
  deploy.host = 'meetmeinouter.space'
  deploy.path = '/'
  deploy.branch = 'master'
  deploy.commit_message = "Deployed at #{Time.now.getlocal} by #{Middleman::Deploy::PACKAGE} #{Middleman::Deploy::VERSION}"
end

activate :blog do |blog|

end
