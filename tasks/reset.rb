desc 'reset the homepage'
task :reset do
  `rm lib/views/home.html && touch lib/views/home.html`
end
