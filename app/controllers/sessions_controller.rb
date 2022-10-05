class SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username]) # look up the user in the database 
        if user&.authenticate(params[:password]) # if the user exists and password is authenticated
            session[:user_id] = user.id # set the user's session 
            render json: user, status: :created # return the user 
        else
            render json: { error: "Invalid username or password" }, status: :unauthorized # if not, render the error
        end
    end

    def destroy
        session.delete :user_id # clears the username out of the session
        head :no_content # returns an empty head with a 204 status code
    end

end
