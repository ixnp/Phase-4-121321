class SessionsController < ApplicationController

    def login
        user = User.find_by(name:params[:username])
        if user&.authenticate(params[:password])
            byebug
            render json:user, status: :ok
        else
            render json: {error: "Invalid Password or Username"}
        end 
    end 
end
