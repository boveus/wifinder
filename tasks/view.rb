desc 'view home page in the default browser'
task :view do
  `xdg-open http://localhost:9000/devices`
end
