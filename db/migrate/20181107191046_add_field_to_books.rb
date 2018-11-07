class AddFieldToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :nyt_review_url, :string
  end
end
