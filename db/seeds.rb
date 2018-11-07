puts 'Cleaning database...'
Book.destroy_all
AmazonReview.destroy_all
Tweets.destroy_all

puts 'Creating books...'
NYTService.new.seed_db

puts 'Searching & assigning Amazon reviews to books...'
AmazonBookScrapingService.new.seed_db

puts 'Searching & assigning tweets and individual aylien tweet result to books...'
TwitterService.tweet_save

puts 'Calling Aylien API to get sentiments from twitter and assigning result to book.aylien_book_results...'
AylienService.twitter_comment_totals

puts 'Finished!'
