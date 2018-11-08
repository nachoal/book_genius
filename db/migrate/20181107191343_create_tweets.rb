class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.references :book, foreign_key: true
      t.string :tweet
      t.string :tweet_location
      t.jsonb :aylient_result_json

      t.timestamps
    end
  end
end
