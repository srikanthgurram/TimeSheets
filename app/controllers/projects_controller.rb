class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  #Show controller
  def show
    if params[:id]
      if Project.exists?(params[:id])
        @project =  Project.find(params[:id])
      else
       render :"errors/notfound"      
      end
    end
  end

  #Works controller
  def works
    if (params[:id])
      if Project.exists?(params[:id])
        @project = Project.find(params[:id])
        @project_works = @project.works.paginate(:page => params[:page], :per_page => 10)
      else
        render :"errors/notfound"
      end
    end
  end

  #Controller to add new Project
  def new
    @project = Project.new
  end 

  #Controller to save the new Project
  def create
    @project = Project.new(params[:project].permit(:name, :default_rate, :company_id, :client_id))
    if @project.valid?
      @project.save
      flash[:notice] = "Successfully created new Project"
      redirect_to @project
    else
      render 'new'
    end
  end

  #Edit Project
  def edit
    @project = Project.find(params[:id])
  end

  #Update Project details
  def update
    @project = Project.find(params[:id])
    if @project.update(params[:project].permit(:name, :default_rate, :company_id, :client_id))
      flash[:notice] = "Successfully Updated Project details"
      redirect_to @project
    else
      render 'edit'
    end
  end

  #Delete Project details
  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      flash[:notice] = "Project deleted Successfully"
      redirect_to @project
    else
      flash[:notice] = "Error in deleting the Project"
      redirect_to @project
    end
  end

end
