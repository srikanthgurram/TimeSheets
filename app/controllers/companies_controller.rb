class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    #render json: @companies
  end

  #Show controller
  def show
    if params[:id]
      if Company.exists?(params[:id])
        @company = Company.find(params[:id])
      else
        render :"errors/notfound"
      end
    end
  end

  #Controller to add new Company
  def new
    @company = Company.new
  end

  #Controller to save new Company
  def create
    @company = Company.new(user_params)
    if @company.valid?
      @company.save
      flash[:notice] = "Successfully updated Company"
      redirect_to @company
    else
      render 'new'
    end
  end

  #Cotnroller to edit
  def edit
    @company = Company.find(params[:id])
  end

  #Update company records
  def update
    @company = Company.find(params[:id])
    if @company.update(user_params)
      flash[:notice] = "Successfully updated Company"
      redirect_to @company
    else
      render 'edit'
    end
  end

  #Delete company record
  def destroy
    @company = Company.find(params[:id])
    if @company.destroy
      flash[:notice] = "Company deleted Successfully"
      redirect_to @company
    else
      flash[:notice] = "Error in deleting the Company"
      redirect_to @company
    end
  end

  private
    def user_params
      params[:company].permit(:name)
    end

end
