class LecturesController < ApplicationController

respond_to :json

  def index

    @lectures=Lecture.where(course_id: params[:course_id])
  end

  def show
    @lecture=Lecture.where(course_id:params[:course_id]).where(lecture_no: params[:id]).first
  end

  # def create
  #   respond_with User.create(user_params)
  # end

  def update
    @lecture=Lecture.where(course_id:params[:course_id]).where(lecture_no: params[:id]).first
    if @lecture.update_attributes lecture_params
      render "lectures/show"
    else
      respond_with @lecture
    end
  end

  def upload
    @lecture=Lecture.where(course_id:params[:course_id]).where(lecture_no: params[:id]).first
  end

  def upload_update
    @lecture=Lecture.where(course_id:params[:course_id]).where(lecture_no: params[:id]).first
    if @lecture.update_attributes upload_params
      render root_path
    else
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

  def lecture_params
    params.require(:lecture).permit(:title, :instructor_id, :content,
                                   :date, :overview,
                                   :course_id )

  end

  def upload_params
    params.require(:lecture).permit(:video,:slide)
  end

end
