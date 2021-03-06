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

  scope :no_reviews, -> { left_joins(:amazon_reviews).where("amazon_reviews.book_id IS NULL") }
  instance_eval { alias without_reviews no_reviews }

  scope :no_aylien_results, -> { left_joins(:aylien_book_results).where("aylien_book_results.book_id IS NULL") }

  scope :no_twitter_aylien, -> { left_joins(:aylien_book_results).where("aylien_book_results.aylien_twitter_json IS NULL")}

  scope :no_indiv_twitter_aylien, -> { left_joins(:tweets).group("book_id").where("tweets.aylient_result_json IS NULL")}

  scope :no_indiv_review_aylien, -> { left_joins(:amazon_reviews).group("book_id").where("amazon_reviews.aylien_result_json IS NULL")}

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
    if aylien_book_results.first.nil?
      "No sentiment analysis available"
    elsif aylien_book_results.first.aylien_twitter_json.nil?
      "Not enough comments on Twitter"
    else
      aylien_book_results.first.aylien_twitter_json["polarity"]
    end
    # aylien_book_results.first.nil? && aylien_book_results.first.aylien_twitter_json.nil? ? "Not enough twitter comments found" : aylien_book_results.first.aylien_twitter_json["polarity"]
  end

  def overall_sentiment
    positive = count_polarity["positive"] + count_polarity_amazon["positive"]
    neutral = count_polarity["neutral"] + count_polarity_amazon["neutral"]
    negative = count_polarity["negative"] + count_polarity_amazon["negative"]
    resultado = neutral + (positive + negative) * Math.cos(60)
    if resultado > 0
      '<p class="emoji">👍</p>'
    else
      if positive > negative
        '<p class="emoji">😐</p>'
      else
        '<p class="emoji">👎</p>'
      end
    end
  end

  def translate_to_emoji(string)
    case string
    when "neutral"
      '<p class="emoji">😐</p>'
    when "positive"
      '<p class="emoji">😃</p>'
    when "negative"
      '<p class="emoji">😠</p>'
    else
      "<p>#{string}</p>"
    end
  end

  def cursor
    positive = count_polarity["positive"] + count_polarity_amazon["positive"]
    neutral = count_polarity["neutral"] + count_polarity_amazon["neutral"]
    negative = count_polarity["negative"] + count_polarity_amazon["negative"]
    total = positive + neutral + negative

    if total != 0
      cursor = {
        positive: ((positive.to_f / total.to_f) * 100).to_i,
        neutral: (((positive.to_f + neutral.to_f) / total.to_f) * 100).to_i,
      }
    else
      cursor = {
        positive: 33.to_i,
        neutral: 66.to_i,
      }
    end
    cursor
  end

  def twitter_polarity_score
    aylien_book_results.first.aylien_twitter_json["polarity_confidence"]
  end

  def amazon_sentiment
    if aylien_book_results.first.nil?
      "No sentiment analysis available"
    elsif aylien_book_results.first.aylien_amazon_json.nil?
      "Not enough reviews on Amazon"
    else
      aylien_book_results.first.aylien_amazon_json["polarity"]
    end
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

  def count_polarity
    counter = Hash.new(0)
    self.tweets.each do |tweet|
      counter[tweet.aylient_result_json['polarity']] += 1 unless tweet.aylient_result_json.nil?
    end
    counter
  end

  def affiliate_assign
    self.amazon_product_url.gsub(/NYTBS-20/,'bookgenius-20')
  end

  def count_polarity_amazon
    counter = Hash.new(0)
    self.amazon_reviews.each do |review|
      counter[review.aylien_result_json['polarity']] += 1 unless review.aylien_result_json.nil?
    end
    counter
  end

  def polarity_percentages
    if count_polarity.empty?
      "empty"
    else
      polarities = []
      polarity_result = count_polarity
      polarity_result.each {|_,v| polarities << v}
      sum = polarities.inject(:+)
      percent = 100
      neutral = polarity_result['neutral']
      positive = polarity_result['positive']
      negative = polarity_result['negative']
      percentages = [neutral, positive, negative]
      percentages.map! { |pe| (pe * percent) / sum }
    end
  end
end
