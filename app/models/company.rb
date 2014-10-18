class Company < ActiveRecord::Base
  has_many :reviews

  def average_sentiment()
    reviews = self.reviews
    num_reviews = reviews.length
    running_average = 0

    reviews.each do |review|
      running_average += (1.0/num_reviews)*review.sentiment_score
    end

    puts 'Running average ' + running_average.to_s
    self.average_sentiment_score = running_average

    if running_average > 0
      label = 'positive'
    elsif running_average == 0
      label = 'neutral'
    else
      label = 'negative'
    end
    self.average_sentiment_label = label

    self.save()
  end

end
