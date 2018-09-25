desc 'serve the viewer folder'
task :serve do
  `rackup config/config.ru`
end
