class SessionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def new
  end

  def create
    params.require(:session).permit(:email,:password)
    warden.authenticate!
    render json: {
      authentication: true,
      message: "Authentication successful"
    }
  end

  def failed
    render status: 401, json: {
      authentication: false,
      errors: warden.message,
      message: "Authentication unsuccessful"
    }
  end

  def destroy
    warden.logout
    render json: {
      status: true,
      message: "Successfully logged out"
    }
  end
end