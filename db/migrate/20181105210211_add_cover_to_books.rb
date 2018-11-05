class AddCoverToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :photo, :string
  end
end
