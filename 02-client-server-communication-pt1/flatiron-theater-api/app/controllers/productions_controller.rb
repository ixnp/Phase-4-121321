class ProductionsController < ApplicationController
    def index 
        render json: Production.all, status: :ok
    end 

    def show
        production = Production.find(params[:id])
        render json: production, include: :production_roles, status: :ok
    end 
end
