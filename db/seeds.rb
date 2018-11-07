# puts 'Cleaning database...'
# Book.destroy_all
# AmazonReview.destroy_all

# puts 'Creating books...'
# NYTService.new.seed_db

puts 'Cleaning reviews...'
AmazonReview.destroy_all

puts 'Searching & assigning Amazon reviews to books...'
AmazonBookScrapingService.new.seed_db

# puts 'Searching & assigning tweets to books...'
# TwitterService.tweet_text_save

# puts 'Calling Aylien API to get sentiments from twitter and assigning result to book.aylien_result...'
# AylienService.book_sentiment_save

puts 'Finished!'
