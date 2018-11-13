class AddFieldToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :creation_date, :datetime
  end
end
