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
    if search.present?
      search_by_category_title_author_and_publisher(search)
    else
      Book.all # not ideal at all with regards to pundit... Should be moved to controller if no way to return the "root" search withouth putting book.all
    end
  end

  def self.new_with_google_json(json)
    {
      book: Book.new(json),
      image_url: json[:book_image]
    }
  end
end
