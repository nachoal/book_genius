class AddFieldsToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :tweets, :text
    add_column :books, :aylien_result, :jsonb
  end
end
