desc 'serve the viewer folder'
task :serve do
  `ruby -run -e httpd -- -p 5000 ./lib/views`
end
