class RemoveFieldFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :nyt_json, :jsonb
  end
end
