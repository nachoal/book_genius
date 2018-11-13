class Book < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :amazon_reviews, dependent: :delete_all
  has_many :aylien_book_results, dependent: :delete_all
  has_many :book_collections, dependent: :destroy
  has_many :collections, through: :book_collections
  mount_uploader :book_image, PhotoUploader

  include PgSearch
  pg_search_scope :search_by_category_title_author_and_publisher,
                  against: %i[category title author publisher],
                  ignoring: :accents,
                  using: {
                    tsearch: {
                      prefix: true,
                      any_word: true,
                    },
                    trigram: {
                      only: %i[title author],
                    },
                  }

  scope :no_tweets, -> { left_joins(:tweets).where("tweets.book_id IS NULL") }
  instance_eval { alias without_tweets no_tweets }

  scope :no_aylien_results, -> { left_joins(:aylien_book_results).where("aylien_book_results.book_id IS NULL") }

  scope :no_twitter_aylien, -> { left_joins(:aylien_book_results).where("aylien_book_results.aylien_twitter_json IS NULL")}

  def self.search(search)
    if search.present?
      search_by_category_title_author_and_publisher(search)
    else
      Book.all # not ideal at all with regards to pundit...
    end
  end

  def self.new_with_google_json(json)
    {
      book: Book.new(json),
      image_url: json[:book_image],
    }
  end

  scope :no_twitter_aylien, -> { left_joins(:aylien_book_results).where('aylien_book_results.aylien_twitter_json IS NULL')}

  scope :with_image, -> { where.not(book_image: '') }

  def aylien_result
    aylien_book_results.first
  end

  def twitter_sentiment
    aylien_book_results.first.nil? ? "Not enough twitter comments found" : aylien_book_results.first.aylien_twitter_json["polarity"]
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
    aylien_book_results.first.aylien_twitter_json["polarity_confidence"]
  end

  def amazon_sentiment
    aylien_book_results.first.aylien_amazon_json["polarity"]
  end

  def amazon_polarity_score
    aylien_book_results.first.aylien_amazon_json["polarity_confidence"]
  end

  def self.random(count)
    with_image.order('random()').limit(count)
  end

  def self.random_images(count)
    with_image.order('random()').limit(count).map do |book|
      book.book_image.url(:thumbnail)
    end
  end
end
