class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json
  def index
    @companies = Company.all
    respond_with(@companies)
  end

  def search
    @company = Company.find_by_name(params[:q])
    if @company.nil?
      redirect_to(:action=>"new", :name =>params[:q])
    else
      redirect_to(:action=>"show", :id =>@company.id)
    end
  end

  def show
    @srcurl = "http://data.scrapelogo.com/"+@company.name+"/logo"
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
      params.require(:company).permit(:name, :description)
    end
end
