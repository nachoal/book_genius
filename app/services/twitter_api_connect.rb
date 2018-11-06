# frozen_string_literal: true

# Class for twitter connection
class TwitterApiConnect
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  # returns an array with all tweets in english
  def clean_search(query)
    @client.search("#{query} book -rt", lang: 'en').map(&:text)
  end
end