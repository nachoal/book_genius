class Book < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :amazon_reviews, dependent: :delete_all
  has_many :aylien_book_results, dependent: :delete_all
  has_many :book_collections, dependent: :destroy
  has_many :collections, through: :book_collections
  mount_uploader :book_image, PhotoUploader

  scope :no_tweets, -> { left_joins(:tweets).where('tweets.book_id IS NULL') }
  instance_eval { alias without_tweets no_tweets }

  scope :no_aylien_results, -> { left_joins(:aylien_book_results).where('aylien_book_results.book_id IS NULL') }

  scope :no_twitter_aylien, -> { left_joins(:aylien_book_results).where('aylien_book_results.aylien_twitter_json IS NULL')}
  def aylien_result
    aylien_book_results.first
  end

  def twitter_sentiment 
     aylien_book_results.first.aylien_twitter_json.nil? ? "Not enough twitter comments found" : aylien_book_results.first.aylien_twitter_json['polarity']
  end

  def translate_to_emoji(string)
    case string
    when "neutral"
      '😐'
    when "positive"
      '😄'
    when "negative"
      '🤬'    
    end
  end

  def twitter_polarity_score
    aylien_book_results.first.aylien_twitter_json['polarity_confidence']
  end

  def amazon_sentiment
    aylien_book_results.first.aylien_amazon_json['polarity']
  end

  def amazon_polarity_score
    aylien_book_results.first.aylien_amazon_json['polarity_confidence']
  end
end
