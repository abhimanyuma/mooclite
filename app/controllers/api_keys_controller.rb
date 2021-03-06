class ApiKeysController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_filter :correct_authorized, :only => [:create,:destroy]
  respond_to :json

  def create
    user = User.find(params[:user_id])
    if user.create_api_key
      render status: 200, json: user.api_keys.last
    else
      render status: 400, json: {}
    end
  end

  def destroy
    user = User.find(params[:user_id])
    if user
      key = user.api_keys.find(params[:id])
      if key && key.destroy
        render status: 200, json: user.api_keys.count
      else
        render status: 400, json: {}
      end
    else
      render status: 400, json: {}
    end
  end



private

  def correct_authorized
    unless current_user && (current_user.id.to_s == params[:user_id])
      render status: 401, json: {}
    end
  end


end
