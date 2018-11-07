class RemoveFieldsFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :twitter_json, :jsonb
    remove_column :books, :amazon_json, :jsonb
    remove_column :books, :perspective_json, :jsonb
    remove_column :books, :aylien_twitter_json, :jsonb
    remove_column :books, :aylien_amazon_json, :jsonb
    remove_column :books, :perspective_twitter_json, :jsonb
    remove_column :books, :perspective_amazon_json, :jsonb
    remove_column :books, :nyt_review, :string
    remove_column :books, :tweets, :text
    remove_column :books, :aylien_result, :jsonb
  end
end
