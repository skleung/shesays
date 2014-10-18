require 'HTTParty'

class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_filter :check_logged_in, only: [:new, :create]
  respond_to :html, :xml, :json

  def index
    @reviews = Review.all
    respond_with(@reviews)
  end

  def show
    respond_with(@review)
  end

  def new
    @company = Company.find(params[:company_id])
    @review = Review.new
    respond_with(@review)
  end

  def edit
  end

  def create
    @company = Company.find(params[:company_id])
    @review = Review.new(review_params)
    @review.encrypted_key = User.hash_email(current_user.email)

    result = run_sentiment_analysis(@review.content)
    @review.sentiment_label = result[:sentiment]
    @review.sentiment_score = result[:score]

    if @review.save
        @company.reviews.append(@review)
        @company.save
        flash[:notice] = 'Review was successfully created.' if @review.save
    end

    puts result
    respond_with(@company)
  end

  def update
    flash[:notice] = 'Review was successfully updated.' if @review.update(review_params)
    respond_with(@review)
  end

  def destroy
    @review.destroy
    respond_with(@review)
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:content)
    end

    def check_logged_in
      if !current_user
        redirect_to(new_user_session_path)
      end
    end

    def run_sentiment_analysis(review_content)
      api_key = '57a09ad8e5e23b3d3b9e83c780a699e7a1a8650e' #lol secure
      url = 'http://access.alchemyapi.com/calls/text/TextGetTextSentiment'
      body = {
        :apikey => api_key,
        :text => review_content,
        :outputMode => 'json',
        :showSourceText => '1'
      }
      response = HTTParty.post(url, :body => body)
      response_content = JSON.parse response.body
      result = {
        :sentiment => response_content["docSentiment"]["type"],
        :score => response_content["docSentiment"]["score"]
      }
    end
end
