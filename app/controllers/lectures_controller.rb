class LecturesController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_filter :correct_authorized , except: [:show]
  respond_to :json, except: [:upload]
  respond_to :html, only: [:upload]


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

    @user = current_user

    render "lectures/upload", layout: false
  end

  def upload_update

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

    @user = current_user

    if @lecture.update_attributes upload_params
      @status = "Success"
      render "lectures/upload",  layout: false
    else
      @status = "Failed"
      render "lectures/upload",  layout: false
    end
  end


  def destroy
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

    respond_with @lecture.destroy()

  end

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
    begin
      params.require(:lecture).permit(:video,:slide)
    rescue
      {}
    end
  end

end
