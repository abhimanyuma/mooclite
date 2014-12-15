class CoursesController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_filter :correct_authorized
  respond_to :json


  def index
    user = User.find(params[:user_id])
    @courses= user.courses
  end

  def show
    user = User.find(params[:user_id])
    @course = user.courses.find(params[:id])
  end

  def create
    user = User.find(params[:user_id])
    @course = user.courses.new
    if @course.update_attributes course_params
      render "courses/show"
    else
      respond_with @course
    end
  end

  def update
    user = User.find(params[:user_id])
    @course = user.courses.find(params[:id])
    if @course.update_attributes course_params
      render "courses/show"
    else
      respond_with @course
    end
  end

  def destroy
    user = User.find(params[:user_id])
    course = user.courses.find(params[:id])
    course.destroy()
    render json: {}
  end

private

  def correct_authorized
    unless current_user && (current_user.id.to_s == params[:user_id])
      render status: 401, json: {}
    end
  end


  def course_params
    params.require(:course).permit(:name,:description,:bio,:offered_by)
  end

end
