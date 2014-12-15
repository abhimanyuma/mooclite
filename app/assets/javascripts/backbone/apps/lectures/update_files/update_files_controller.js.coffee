@Mooclite.module "LecturesApp.UpdateFiles", (UpdateFiles, App, Backbone, Marionette, $, _) ->

  class UpdateFiles.Controller extends App.Controllers.Application

    initialize:(options) ->

      {course,lecture,course_id,lecture_id} = options
      course_id ?= course.id
      lecture_id ?= lecture_id


      App.redirectIfNotLoggedIn("/courses/#{course_id}/lectures/#{lecture_id}/update_files")

      if App.currentUser && App.currentUser.id

        lecture = App.request "lecture:entity", course_id, lecture_id unless lecture

        lecture.course_id ?= course_id

        @view = @getUpdateView lecture

        @show @view,
          loading:
            entities: [lecture]

    getUpdateView: (lecture) ->
      new UpdateFiles.Update
        model:lecture
