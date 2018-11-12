class Book < ApplicationRecord
  has_many :tweets, dependent: :delete_all
  has_many :amazon_reviews, dependent: :delete_all
  has_many :aylien_book_results, dependent: :delete_all
  mount_uploader :book_image, PhotoUploader

  include PgSearch
  pg_search_scope :search_by_category_title_author_and_publisher,
                  against: %i[category title author publisher],
                  ignoring: :accents,
                  using: {
                    tsearch: {
                      prefix: true,
                      any_word: true
                    },
                    trigram: {
                      only: %i[title author]
                    }
                  }

  def self.search(search)
    if search
      search_by_category_title_author_and_publisher(search)
    else
      Book.all
    end
  end

  def self.new_with_google_json(json)
    params = {
      title: json['title'],
      author: json['author']
    }
    new(params)
  end
end
