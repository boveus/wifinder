desc 'launch the viewer'
task :serve do
  `ruby -run -e httpd -- -p 5000 ./lib/views/home.html`
end
