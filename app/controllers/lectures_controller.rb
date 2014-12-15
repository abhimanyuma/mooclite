class LecturesController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_filter :correct_authorized , except: [:show]
  respond_to :json

  def index
    @lectures=Lecture.where(course_id: params[:course_id])
  end

  def show
    if params[:course_id]
      unless current_user && (current_user.id.to_s == params[:user_id])
        render status: 401, json: {}
        return false
      end

      user = User.find(params[:user_id])

      unless user
        render402
        return false
      end

      course = user.courses.find(params[:course_id])

      unless course
        render404
        return false
      end

      @lecture = course.lectures.find(params[:id])

      unless @lecture
        render404
        return false
      end
    else
      render400
    end

  end

  def create
    user = User.find(params[:user_id])
    if user
      course = user.courses.find(params[:course_id])
      if course
        @lecture = course.lectures.create(lecture_params)
        if @lecture
          render "lectures/show"
        else
          render500
        end
      else
        render404
      end
    else
      render402
    end
  end

  def update

    user = User.find(params[:user_id])

    unless user
      render402
      return false
    end

    course = user.courses.find(params[:course_id])

    unless course
      render404
      return false
    end

    @lecture = course.lectures.find(params[:id])

    unless @lecture
      render404
      return false
    end


    if @lecture.update_attributes lecture_params
      render "lectures/show"
    else
      render500
    end
  end

  def upload
    @lecture=Lecture.where(course_id:params[:course_id]).where(lecture_no: params[:id]).first
  end

  def upload_update
    @lecture=Lecture.where(course_id:params[:course_id]).where(lecture_no: params[:id]).first
    if @lecture.update_attributes upload_params
      flash[:success] = "Model updated"
      render "lectures/upload"
    else
      flash[:error] = "Contains errors"
      render "lectures/upload"
    end
  end
  # def update
  #   respond_with User.update(params[:id],user_params)
  # end

  # def destroy
  #   respond_with User.destroy(params[:id])
  # end

private

  def correct_authorized
    unless current_user && (current_user.id.to_s == params[:user_id])
      render status: 401, json: {}
    end
  end

  def lecture_params
    params.require(:lecture).permit(:title, :instructor_id, :content,
                                   :date, :overview,
                                   :course_id )

  end

  def upload_params
    params.require(:lecture).permit(:video,:slide)
  end

end
