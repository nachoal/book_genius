class AddNytReviewToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :nyt_review, :string
  end
end
