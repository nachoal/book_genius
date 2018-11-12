class GoogleBooksService

  def lists(search)
    book_list = []
    api_key = ENV['GOOGLE_BOOKS_API']
    doc = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=#{search}&printType=books&langRestrict=en&orderBy=newest&key=#{api_key}")
    doc['items'].each do |item|
      book = {
        title: item['volumeInfo']['title'],
        author: item['volumeInfo']['authors'],
        publisher: item['volumeInfo']['publisher'],
        description: item['volumeInfo']['description'],
        category: item['volumeInfo']['categories'],
        book_image: item['volumeInfo']['imageLinks']['thumbnail']
      }
      book_list << book
    end
    book_list
  end
end
