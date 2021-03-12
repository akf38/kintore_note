class CreateTweetComments < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_comments do |t|
      t.integer :user_id,  null: false
      t.integer :tweet_id, null: false
      t.text    :body,     null: false
      t.string  :image_id
      t.timestamps
    end
  end
end
