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
      book.aylien_book_results.each { |result| result.destroy }
      p appended_tweets = book.tweets.map { |twit| twit.tweet }.join(' ')
      p appended_reviews = book.amazon_reviews.map { |review| review.review  }.join(' ')
        aylien_results = AylienBookResult.new(
        aylien_twitter_json: text_api.sentiment(text: appended_tweets),
        aylien_amazon_json: text_api.sentiment(text: appended_reviews),
        aylien_nyt_json: text_api.sentiment(url: book.nyt_review_url),
        book: book
      )
      p aylien_results.save
    end
  end

  def self.missing_aggregated_tweets
    books = Book.no_twitter_aylien
    books.each do |book|
      appended_tweets = book.tweets.map { |twit| twit.tweet }.join(' ')
      p "appended tweets? #{!appended_tweets.empty?}"
      p "updating #{book.title} with the appended tweets"
      book.aylien_book_results.first.update(aylien_twitter_json: text_api.sentiment(text: appended_tweets) )
    end
  end

  def self.individual_tweet_sentiment
    tweets = Tweet.all.where(aylient_result_json: nil)
    tweets.each do |tweet|
      tweet.update(aylient_result_json: AylienService.text_api.sentiment(text: tweet.tweet))
    end
  end

  def self.book_individual_tweet_sentiment
    books = Book.all[0..9]
    books.each do |book|
      if book.tweets.size > 50
        book.tweets[0..49].each do |tweet|
          tweet.update(aylient_result_json: AylienService.text_api.sentiment(text: tweet.tweet))
        end
      else
        book.tweets[0..tweets.size].each do |tweet|
          tweet.update(aylient_result_json: AylienService.text_api.sentiment(text: tweet.tweet))
        end
      end
    end
  end

  def self.single_book_individual_tweet_sentiment(book)
    if book.tweets.size > 50
      book.tweets[0..49].each do |tweet|
        tweet.update(aylient_result_json: AylienService.text_api.sentiment(text: tweet.tweet))
      end
    else
      book.tweets[0..tweets.size].each do |tweet|
        tweet.update(aylient_result_json: AylienService.text_api.sentiment(text: tweet.tweet))
      end
    end
  end

  def self.individual_review_sentiment
    reviews = AmazonReview.all.where(aylien_result_json: nil)
    reviews.each do |review|
      review.update(aylien_result_json: AylienService.text_api.sentiment(text: review.review))
    end
  end
end
