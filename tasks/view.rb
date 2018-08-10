desc 'view home page in the default browser'
task :view do
  `xdg-open ./lib/views/home.html`
end
