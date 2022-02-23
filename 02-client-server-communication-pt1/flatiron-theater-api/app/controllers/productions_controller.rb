class ProductionsController < ApplicationController
    wrap_parameters format: []
    def index 
        render json: Production.all, status: :ok
    end 

    def show
        byebug
        production = Production.find(params[:id])
        render json: production, include: :production_roles, status: :ok
    end 

    def create
        production = Production.create!(production_params)
        # if production.valid?
        #     render json: production, status: :created
        # else
        #     render json: {errors: production.errors.full_messages}
        # end 
    rescue ActiveRecord::RecordInvalid => invalid 
        byebug
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity

    end 

    private

    def production_params
        params.permit(:title, :genre, :description, :budget, :image, :director, :ongoing)
    end 
end
