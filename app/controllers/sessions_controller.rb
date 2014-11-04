class SessionsController < ApplicationController

  def new
  end

  def create
    user = env['warden'].authenticate
    if user
      render json: {
        authentication: true,
        message: "Authentication successful"
      }
    else
      render status: 402, json: {
        authentication: false,
        error: true,
        message: "Authentication unsuccessful"
      }
    end
  end

  def destroy
    env['warden'].logout
    render json: {
      status: true
      message: "Successfully logged out"
    }
  end
end