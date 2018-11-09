class CreateBookCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :book_collections do |t|
      t.references :collection, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
