class CoursesController < ApplicationController
  respond_to :json

  def index
    @courses= nil
  end

  def show
    @course= Course.find(params[:id]) 
  end

  def create
    respond_with Course.create(course_params)
  end

  def update
    respond_with Course.update(params[:id],course_params)
  end

  def destroy
    respond_with Course.destroy(params[:id])
  end

private
  
  def course_params
    params.require(:course).permit(:name,:description,:bio,:offered_by)
  end

end
