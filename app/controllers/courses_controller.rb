class CoursesController < ApplicationController
  respond_to :json

  def index
    @courses= Course.all
  end

  def show
    @course= Course.find(params[:id]) 
  end

  def create
    @course = Course.new
    if @course.update_attributes course_params
      render "courses/show"
    else
      respond_with @course
    end
  end

  def update
    sleep 2
    @course = Course.find(params[:id])
    if @course.update_attributes course_params
      render "courses/show"
    else
      respond_with @course
    end
  end

  def destroy
    respond_with Course.destroy(params[:id])
  end

private
  
  def course_params
    params.require(:course).permit(:name,:description,:bio,:offered_by)
  end

end
