class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json
  def index
    @reviews = Review.all
    render "index"
  end

  def show
    respond_with(@review)
  end

  def new
    @review = Review.new
    render "new"
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    flash[:notice] = 'Review was successfully created.' if @review.save
    respond_with(@review)
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
