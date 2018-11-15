class AmazonBookScrapingService
  class AmazonError < StandardError; end
  include HTTParty

  def get_book_data_asin(book_and_author)
    url = "https://www.amazon.com/s/ref=nb_sb_noss"
    # url = "https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Dstripbooks-intl-ship&field-keywords=#{book_and_author.html_safe}"
    # html_file = HTTParty.get(URI.decode(url)
    puts "Getting book ASIN number"

    options = {
      query: {
        url: "search-alias%3Dstripbooks-intl-ship",
        field_keywords: book_and_author.html_safe,
      },
    }

    process_url(url, options).xpath('//li[@id="result_0"][@data-asin]')[0].attributes['data-asin'].value
  end

  def get_book_reviews(data_asin)
    url = "https://www.amazon.com/dp/#{data_asin}/#customerReviews"
    reviews = process_url(url).xpath('//div[@data-hook="review-collapsed"]')
    process_reviews(reviews)
  end

  def get_all_book_reviews(data_asin, max_page)
    puts "Connecting to main page of book to retrieve total number of pages with reviews"
    first_url = "https://www.amazon.com/product-reviews/#{data_asin}/ref=cm_cr_getr_d_paging_btm_1?ie=UTF8&reviewerType=all_reviews&pageNumber=1"
    review_count = process_url(first_url).xpath('//span[@data-hook="total-review-count"]').text.to_i
    total_page = review_count % 10
    puts "The book with with ASIN #{data_asin} has #{total_page} pages of reviews (#{total_page * 10} reviews in total)"
    page = 1
    review_list = []
    loop do
      url_str = url(data_asin, page)
      puts "Getting reviews of book (ASIN: #{data_asin}) on page #{page} of Amazon"
      reviews = process_url(url_str).xpath('//span[@data-hook="review-body"]')
      puts "Getting dates of reviews of book (ASIN: #{data_asin}) on page #{page} of Amazon"
      creation_dates = process_url(url_str).xpath('//span[@data-hook="review-date"]')
      i = 1
      reviews.each do |r|
        puts "Book (ASIN: #{data_asin}): Fetching review and date #{i} of page #{page}"
        review = {
          text: r.children.text,
          date: creation_dates[i - 1].children.text,
        }
        review_list << review
        puts "Waiting 0.5 sec before fetching next review"
        sleep(0.5)
        i += 1
      end
      page += 1
      top_page = (total_page >= max_page ? max_page : total_page)
      break if page > top_page
      puts "Waiting 0.5 sec before fectching next page of reviews"
      sleep(0.5)
    end
    review_list
  end

  def seed_db(max_page)
    Book.all.each do |book|
      input = "#{book.title} #{book.author} #{book.publisher}"
      data_asin = get_book_data_asin(input)
      get_all_book_reviews(data_asin, max_page).each do |review|
        if review[:text]
          date = review[:date] ? review[:date].to_datetime : nil
          new_review = AmazonReview.new(
            review: review[:text],
            creation_date: date,
            book: book
          )
          new_review.save
        else
          next
        end
      end
    end
  end

  private

  def url(data_asin, page)
    a = "https://www.amazon.com/product-reviews/#{data_asin}/ref=cm_cr_getr_d_paging_btm_next_#{page}?ie=UTF8&reviewerType=all_reviews&pageNumber=#{page}"
    b = "https://www.amazon.com/product-reviews/#{data_asin}?ie=UTF8&reviewerType=all_reviews&pageNumber=#{page}"
    [a, b].sample
  end

  def process_url(url, options = {})
    i = 1
    html_file = HTTParty.get(url, options)
    raise AmazonError, "Code not 200. Actual: #{html_file.code}" unless html_file.code == 200

    puts 'Amazon let us through! Processing url wiht Nokogiri'
    Nokogiri::HTML(html_file)
  rescue AmazonError => error
    puts "Amazon didn't let us through..."
    puts error
    puts 'Retrying in 5 seconds'
    sleep 5
    i += 1
    if i < 4
      retry
    else
      abort ("Amazon is blocking us... Abort!")
    end
  end

  def process_reviews(reviews)
    review_list = []
    reviews.each do |review|
      review_list << review.children.text
    end
    review_list
  end
end
