class CreateAmazonReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :amazon_reviews do |t|
      t.text :review
      t.jsonb :aylien_result_json
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
