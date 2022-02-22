class ProductionsController < ApplicationController
    def index
       productions = Production.all
       render json: productions, status: :ok 
       # render json: Production.all
    end 

    def show
        production = Production.find(params[:id])
        render json: production, include: :production_roles
    end 

end
