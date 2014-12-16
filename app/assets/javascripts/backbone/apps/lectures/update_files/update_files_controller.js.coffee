@Mooclite.module "LecturesApp.UpdateFiles", (UpdateFiles, App, Backbone, Marionette, $, _) ->

  class UpdateFiles.Controller extends App.Controllers.Application

    initialize:(options) ->

      {course,lecture,course_id,lecture_id} = options
      course_id ?= course.id
      lecture_id ?= lecture.id


      App.redirectIfNotLoggedIn("/courses/#{course_id}/lectures/#{lecture_id}/update_files")


      if App.currentUser && App.currentUser.id

        lecture = App.request "lecture:entity", course_id, lecture_id unless lecture

        lecture.course_id ?= course_id

        @view = @getUpdateView lecture

        @listenTo @view, "cancel:update:file:button:clicked", ->
          App.vent.trigger "lecture:update:files:cancelled", course_id, lecture

        @listenTo @view, "submit:update:file:button:clicked", ->
          upload_iframe = $("iframe#lecture-upload-iframe").contents().find("#lecture-upload-form")
          upload_iframe.submit()

        @listenTo @view, "show", ->
          $("#lecture-upload-iframe").load () ->

            iframeBody = $('#lecture-upload-iframe').contents().find("body")
            iframeHeight = iframeBody.prop("scrollHeight")
            iframeWidth = iframeBody.prop("scrollWidth")
            $("#lecture-upload-iframe").height(iframeHeight+10)
            $("#lecture-upload-iframe").width(iframeWidth+10)

            lectureMessage = $('#lecture-upload-iframe').contents().find(".lecture-upload-message").html()

            if lectureMessage == "Success"
              App.vent.trigger "lecture:update:files:success", course_id, lecture
            else if lectureMessage == "Failed"
              toastr.error("File uploading failed","Upload failed")

        @show @view,
          loading:
            entities: [lecture]

    getUpdateView: (lecture) ->
      new UpdateFiles.Update
        model:lecture
