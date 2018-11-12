class GoogleBooksService

  def lists(search)
    book_list = []
    api_key = ENV['GOOGLE_BOOKS_API']
    doc = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=#{search}&printType=books&langRestrict=en&orderBy=newest&key=#{api_key}")
    doc['items'].each do |item|
      volumeInfo = item['volumeInfo']
      image_url = volumeInfo['imageLinks']['thumbnail'].nil? ? 'https://via.placeholder.com/326x495' : volumeInfo['imageLinks']['thumbnail']
      book = {
        title: volumeInfo['title'],
        author: volumeInfo['authors']&.first,
        publisher: volumeInfo['publisher'],
        description: volumeInfo['description'],
        category: volumeInfo['categories']&.first,
        book_image: image_url
      }
      book_list << book
    end
    book_list.uniq { |book| [ book[:title], book[:author] ] }
  end
end
