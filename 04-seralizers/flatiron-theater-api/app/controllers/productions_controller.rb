class ProductionsController < ApplicationController
    def index 
        render json: Production.all, status: :ok
    end 

    def show
        production = Production.find(params[:id])
        render json: production, include: :production_roles, status: :ok
    end 

    def create
        production = Production.create!(production_params)
    end 

    def update 
        production = Production.find(params[:id])
        production.update!(production_params)
        render json: production, status: :ok
    end 

    def destroy
        production = Production.find(params[:id])
        production.destroy
        head :no_content 
    end 

    private


    def production_params
        params.permit(:title, :genre, :description, :budget, :image, :director, :ongoing)
    end 

end
