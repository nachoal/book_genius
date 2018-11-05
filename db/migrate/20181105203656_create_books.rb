class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :author
      t.string :publisher
      t.string :amazon_product_url
      t.string :book_image
      t.jsonb :twitter_json
      t.jsonb :nyt_json
      t.jsonb :amazon_json
      t.jsonb :perspective_json
      t.jsonb :aylien_twitter_json
      t.jsonb :aylien_amazon_json
      t.jsonb :perspective_twitter_json
      t.jsonb :perspective_amazon_json

      t.timestamps
    end
  end
end
