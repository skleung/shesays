class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json
  def index
    redirect_to(:controller=>"welcome", :action=>"index")
  end

  def search
    @company = Company.find_by_name(params[:q].downcase)
    if @company.nil?
      redirect_to(:action=>"new", :name =>params[:q].downcase)
    else
      redirect_to(:action=>"show", :id =>@company.id)
    end
  end

  def show
    @logo_url = get_company_logo_url(@company.name)
    respond_with(@company)
  end

  def new
    @name = params[:name]
    @company = Company.new
    respond_with(@company)
  end

  def edit
  end

  def create
    @company = Company.new(company_params)
    @company.save
    respond_with(@company)
  end

  def update
    @company.update(company_params)
    respond_with(@company)
  end

  def destroy
    @company.destroy
    respond_with(@company)
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      #force downcase
      params[:company][:name] = params[:company][:name].downcase
      params.require(:company).permit(:name, :description)
    end

    def get_company_logo_url(company_name)
      require 'image_suckr'
      suckr = ImageSuckr::GoogleSuckr.new
      url = suckr.get_image_url({"q" => company_name + " logo", "rsz" => 1})
    end

end
