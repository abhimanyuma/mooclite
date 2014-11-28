class UsersController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_filter :authorize, :only => [:update,:destroy]
  respond_to :json

  def create
    respond_with User.create(user_params)
  end

  def me
    if current_user
      @user = current_user
      render "users/show"
    else
      render status: 401, json: {}
    end
  end


  def update
    respond_with User.update(params[:id],user_params)
  end

  def destroy
    respond_with User.destroy(params[:id])
  end

private

  def authorize
    id_params
    unless current_user.owns(params[:id])
      render status: 401, json: {}
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
  end

  def id_params
    params.require(:user).permit(:id)
  end

end
