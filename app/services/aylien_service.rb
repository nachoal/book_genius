require 'aylien_text_api'

class AylienService
  def self.text_api
    AylienTextApi::Client.new(app_id: ENV['AYLIEN_APP_ID'], app_key: ENV['AYLIEN_APP_KEY'])
  end

  def self.book_sentiment_save
    books = Book.all
    books.each do |book|
      book.aylien_twitter_json = text_api.sentiment(text: book.tweets)
      book.save!
    end
  end

  def self.twitter_comment_totals
    books = Book.all
    books.each do |book|
      appended_tweets = book.tweets.map { |twit| twit.tweet }.join(' ')
      book.aylien_book_results.create(aylien_twitter_json: text_api.sentiment(text: appended_tweets))
    end
  end
end
