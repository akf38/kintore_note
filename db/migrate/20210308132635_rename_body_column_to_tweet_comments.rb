class RenameBodyColumnToTweetComments < ActiveRecord::Migration[5.2]
  def change
    rename_column :tweet_comments, :body, :content
  end
end
