class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
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
    if @review.save
        @company.reviews.append(@review)
        @company.save
        flash[:notice] = 'Review was successfully created.' if @review.save
    end
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
end
