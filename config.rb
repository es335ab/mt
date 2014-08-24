###
# Compass
###

activate :livereload

set :css_dir, 'css'

set :js_dir, 'js'

set :images_dir, 'img'

activate :blog do |blog|
  blog.layout = "article"
  blog.prefix = "html"
  blog.sources = ":title.html"
  blog.permalink = ":title.html"
end

# Markdown configuration
set :markdown_engine, :kramdown
set :markdown, :layout_engine => :erb,
               :tables => true,
               :autolink => true,
               :smartypants => true
# Build-specific configuration
configure :build do
  activate :minify_css
  activate :sprockets
  activate :relative_assets
end

compass_config do |config|
  config.output_style = :compressed
end
