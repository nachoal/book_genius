puts 'Cleaning database...'
Book.destroy_all

puts 'Creating books...'
NYTService.new.seed_db

puts 'Searching & assigning tweets to books...'
TwitterService.tweet_save

# puts 'Searching & assigning Amazon reviews to books...'
# AmazonBookScrapingService.new.seed_db

puts 'Calling Aylien API to get sentiments from twitter and reviews and assigning to proper table columns...'
AylienService.aggregated_tweets_reviews_sentiment

# puts 'Getting Aylien sentiment for each individual tweet'
# AylienService.individual_tweet_sentiment

# puts 'Getting Aylien sentiment for each individual Amazon review'
# AylienService.individual_review_sentiment

puts 'Finished!'

# 20.times do
#   Book.create!(
#     title: Faker::Book.title,
#     description: Faker::Lorem.sentence(rand(3..4)),
#     author: Faker::Book.author,
#     publisher: Faker::Book.publisher,
#     category: Faker::Book.genre
#   )
# end
