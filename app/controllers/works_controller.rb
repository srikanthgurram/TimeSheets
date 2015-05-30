class WorksController < ApplicationController
  def index
    @works = Work.all.paginate(:page => params[:page], :per_page => 10).order(date_time_performed: :desc)
  end

  def show
    if (params[:id])
      if(Work.exists?(params[:id]))
       @work =  Work.find(params[:id])
      else
        render :"errors/notfound"
      end
    end
  end

  #Contoller to add new Work
  def new
    @work = Work.new
  end
  
  #Controller to sav new Work
  def create
    @work = Work.new(user_params)
    if @work.valid?
      @work.save
      flash[:notice] = 'Successfully added new work details'
      redirect_to @work
    else
      render 'new'
    end
  end
  
  #Edit Work
  def edit
    @work =  Work.find(params[:id])
  end

  #Update Work details
  def update
    @work =  Work.find(params[:id])
    if @work.update(user_params)
      flash[:notice] = 'Successfully updated work details'
      redirect_to @work
    else
      render 'edit'
    end
  end
  
  #Delete Work details
  def destroy
    @work = Work.find(params[:id])
    if @work.destroy
      flash[:notice] = "Work deleted Successfully"
      redirect_to @work
    else
      flash[:notice] = "Error in deleting the Work"
      redirect_to @work
    end
  end

  private
    def user_params
      params[:work].permit(:employee_id, :project_id, :hours, :work_details, :date_time)
    end

end
