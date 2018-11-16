# frozen_string_literal: true

# Class for twitter connection
class TwitterService
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def self.client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def self.tweet_save(books = nil)
    books ||= Book.all
    books = [books] if books.is_a?(Book)
    books.each do |book|
      client.search("#{book.title} book -rt", lang: 'en').each do |tweety|
        p "creating tweets for book #{book.id}"
          book.tweets.create(
          tweet: tweety.text,
          tweet_location: tweety.user.location,
          creation_date: tweety.created_at
        )
      end
    end
  end

  def self.tweet_update(books = nil)
    books ||= Book.all
    books = [books] if books.is_a?(Book)
    books.each do |book|
      # destroy all tweets before creating new tweets
      book.tweets.each {|tweet| tweet.destroy}
      client.search("#{book.title} book -rt", lang: 'en').each do |tweety|
        p "creating tweets for book #{book.id}"
          book.tweets.create(
          tweet: tweety.text,
          tweet_location: tweety.user.location,
          creation_date: tweety.created_at
        )
      end
    end
  end

  def self.display_tweets(book)
    urls = []
    html_codes = []
    client.search("#{book.title} book -rt", lang: 'en').take(4).each do |search_result|
      urls << search_result.urls[0].expanded_url.to_str
    end
    urls.each do |url|
      begin        
        embed = client.oembed(url).html
        html_codes << embed
      rescue Twitter::Error::NotFound
        puts "Skipping invalid url #{url}"
      end
    end
    html_codes
  end
end


