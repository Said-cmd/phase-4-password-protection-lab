class UsersController < ApplicationController
    def create
        user = User.create(user_params) # user is created using the paramters
        if user.valid? # if the user's parameters are valid
            session[:user_id] = user.id # start their session
            render json: user, status: :created # return the user
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity # if not, render the errors
        end
    end

    def show
        user = User.find_by(id: session[:user_id]) # find the user by their session id to determine if they're logged in
        if user  # if the user had an active session authorise them
            render json: user, status: :ok
        else
            render json: { error: "Unauthorized" }, status: :unauthorized # if not block them from viewing anything and render the error
        end
    end

    private 

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
