# DO NOT FORGET TO MODIFY SERVICE IN ORDER TO SCRAPE ALL REVIEWS FOR ALL BOOKS

class AmazonBookScrapingService
  include HTTParty

  def get_book_data_asin(book_and_author)
    url = "https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Dstripbooks-intl-ship&field-keywords=#{book_and_author}"
    # html_file = HTTParty.get(URI.decode(url)
    process_url(url).xpath('//li[@id="result_0"][@data-asin]')[0].attributes['data-asin'].value
  end

  def get_book_reviews(data_asin)
    url = "https://www.amazon.com/dp/#{data_asin}/#customerReviews"
    reviews = process_url(url).xpath('//div[@data-hook="review-collapsed"]')
    process_reviews(reviews)
  end

  def get_all_book_reviews(data_asin)
    first_url = "https://www.amazon.com/product-reviews/#{data_asin}/ref=cm_cr_getr_d_paging_btm_1?ie=UTF8&reviewerType=all_reviews&pageNumber=1"
    review_count = process_url(first_url).xpath('//span[@data-hook="total-review-count"]').text.to_i
    max_page = review_count % 10
    page = 1
    review_list = []
    loop do
      url_str = url(data_asin, page)
      reviews = process_url(url_str).xpath('//span[@data-hook="review-body"]')
      reviews.each do |review|
        review_list << review.children.text
      end
      page += 1
      break if page > 9 # max_page
    end
    review_list
  end

  def seed_db
    Book.take(5).each do |book|
    # book = Book.first # fetching reviews for only one book. To be removed once everything is ready and in production.
      input = "#{book.title} #{book.author} #{book.publisher}"
      data_asin = get_book_data_asin(input)
      get_all_book_reviews(data_asin).each do |review|
        if review
          new_review = AmazonReview.new(
            review: review,
            book: book
          )
          new_review.save
        else
          next
        end
      end
    # end
  end

  private

  def url(data_asin, page)
    # "https://www.amazon.com/product-reviews/#{data_asin}/ref=cm_cr_getr_d_paging_btm_next_#{page}?ie=UTF8&reviewerType=all_reviews&pageNumber=#{page}"
    "https://www.amazon.com/product-reviews/#{data_asin}?ie=UTF8&reviewerType=all_reviews&pageNumber=#{page}"
  end

  def process_url(url)
    html_file = HTTParty.get(url)
    Nokogiri::HTML(html_file)
  end

  def process_reviews(reviews)
    review_list = []
    reviews.each do |review|
      review_list << review.children.text
    end
    review_list
  end
end
