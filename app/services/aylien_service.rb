require 'aylien_text_api'

class AylienService
  def self.text_api
    AylienTextApi::Client.new(app_id: ENV['AYLIEN_APP_ID'], app_key: ENV['AYLIEN_APP_KEY'])
  end

  # def self.book_sentiment_save
  #   books = Book.all
  #   books.each do |book|
  #     book.aylien_twitter_json = text_api.sentiment(text: book.tweets)
  #     book.save!
  #   end
  # end

  def self.aggregated_tweets_reviews_sentiment
    books = Book.all
    books.each do |book|
      p appended_tweets = book.tweets.map { |twit| twit.tweet }.join(' ')
      p appended_reviews = book.amazon_reviews.map { |review| review.review  }.join(' ')
      p aylien_results = AylienBookResult.new(
        aylien_twitter_json: text_api.sentiment(text: appended_tweets),
        aylien_amazon_json: text_api.sentiment(text: appended_reviews),
        aylien_nyt_json: text_api.sentiment(url: book.nyt_review_url),
        book: book
      )
      p aylien_results.save
    end
  end

  def self.individual_tweet_sentiment
    tweets = Tweet.all
    tweets.each do |tweet|
      tweet.update(aylient_result_json: AylienService.text_api.sentiment(text: tweet.tweet))
    end
  end

  def self.individual_review_sentiment
    reviews = AmazonReview.all
    reviews.each do |review|
      review.update(aylien_result_json: AylienService.text_api.sentiment(text: review.review))
    end
  end
end
