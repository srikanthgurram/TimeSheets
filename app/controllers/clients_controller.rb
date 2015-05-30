class ClientsController < ApplicationController
    def index
        @clients = Client.all
    end

    def show
      if (params[:id])
        if Client.exists?(params[:id])
          @client =  Client.find(params[:id])
          @client_projects = @client.projects.paginate(:page => params[:page], :per_page => 10)
        else
          render :"errors/notfound"
        end
      end
    end

    #Controller to add new Client
    def new
      @client = Client.new
    end

    #Controller to save new Client
    def create
      @client = Client.new(params[:client].permit(:name, :company_id))
      if @client.valid?
        @client.save
        flash[:notice] = "Successfully added new client"
        redirect_to @client
      else
        render 'new'
      end
    end

    #Edit client
    def edit
      @client = Client.find(params[:id])
    end

    #Update client records
    def update
      @client = Client.find(params[:id])

      if @client.update(params[:client].permit(:name, :company_id))
        flash[:notice] = "Successfully updated the client"
        redirect_to @client
      else
        render 'edit'
      end
    end

    #Delete company records
    def destroy
    @client = Client.find(params[:id])
    if @client.destroy
      flash[:notice] = "Client deleted Successfully"
      redirect_to @client
    else
      flash[:notice] = "Error in deleting the Client"
      redirect_to @client
    end
  end

end
