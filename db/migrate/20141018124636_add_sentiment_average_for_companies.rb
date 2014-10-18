class AddSentimentAverageForCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :average_sentiment_score, :float
    add_column :companies, :average_sentiment_label, :string
  end
end
