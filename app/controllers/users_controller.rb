class UsersController < ApplicationController

respond_to :json

  def index
    @users=User.all 
  end

  def show
    @user=User.find(params[:id])
  end

  def create
    respond_with User.create(user_params)
  end

  def update
    respond_with User.update(params[:id],user_params)
  end

  def destroy
    respond_with User.destroy(params[:id])
  end

private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :institute,
                                   :role, :slug)

  end

end
