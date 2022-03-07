class UsersController < ApplicationController
    skip_before_action :authorized_user, only: [:create]

    def create 
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end 

    def show
        render json: current_user, status: :ok
    end 

    private

    def user_params
        params.permit(:name, :email, :password)
    end 
end
