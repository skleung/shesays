class UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :xml, :json
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    encrypted_key = User.hash_email(@user.email)
    @reviews = Review.where(:encrypted_key => encrypted_key)
    unless @user == current_user
      redirect_to root_path, :alert => "Access denied."
    end
  end

end
