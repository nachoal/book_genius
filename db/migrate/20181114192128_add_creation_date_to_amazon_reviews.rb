class AddCreationDateToAmazonReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :amazon_reviews, :creation_date, :datetime
  end
end
