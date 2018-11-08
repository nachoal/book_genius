class NYTService
  include HTTParty
  base_uri 'https://api.nytimes.com/svc/books/v3/lists'

  def initialize
    @options = { query: { api_key: ENV['NYT_API_KEY'] } }
  end

  def lists
    self.class.get('/overview.json', @options)['results']['lists']
  end

  def get_clean_category(category)
    YAML.load_file("#{Rails.root.to_s}/config/book_categories.yml")[category]
  end

  def seed_db
    self.lists.each do |list|
      category = get_clean_category(list['list_name'])
      list['books'].each do |book|
        image_url = book['book_image'] || 'https://via.placeholder.com/326x495'
        new_book = Book.new(
          title: book['title'],
          author: book['author'],
          description: book['description'],
          category: category,
          publisher: book['publisher'],
          amazon_product_url: book['amazon_product_url'],
          nyt_review: book['book_review_link']
        )
        new_book.remote_book_image_url = image_url
        new_book.save
      end
    end
  end
end
