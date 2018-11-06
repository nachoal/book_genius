puts 'Cleaning database...'
Book.destroy_all

puts 'Creating books...'

NYTService.new.seed_db

puts 'Finished!'
