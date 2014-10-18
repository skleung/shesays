class AddSentimentAnalysisToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :sentiment_label, :string
    add_column :reviews, :sentiment_score, :float
  end
end
