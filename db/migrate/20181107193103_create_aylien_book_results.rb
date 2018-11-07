class CreateAylienBookResults < ActiveRecord::Migration[5.2]
  def change
    create_table :aylien_book_results do |t|
      t.references :book, foreign_key: true
      t.jsonb :aylien_twitter_json
      t.jsonb :aylien_amazon_json
      t.jsonb :aylien_nyt_json

      t.timestamps
    end
  end
end
