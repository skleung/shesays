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

    def check_logged_in
      if !current_user
        redirect_to(new_user_session_path)
      end
    end
end
