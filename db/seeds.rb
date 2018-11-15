# puts 'Cleaning database...'
# Book.destroy_all

# puts 'Creating books...'
# NYTService.new.seed_db

# puts 'Searching & assigning tweets to books...'
# TwitterService.tweet_save

# puts 'Getting Aylien sentiment for each individual tweet'
# AylienService.individual_tweet_sentiment

puts 'Searching & assigning Amazon reviews to books...'
AmazonBookScrapingService.new.seed_db(9) # Parameter: max number of review pages to scrape"

puts 'Getting Aylien sentiment for each individual Amazon review'
AylienService.individual_review_sentiment

puts 'Getting Aylien sentiment for aggregated tweets and aggregated reviews | Assigning result to book.aylien_book_results...'
AylienService.aggregated_tweets_reviews_sentiment
