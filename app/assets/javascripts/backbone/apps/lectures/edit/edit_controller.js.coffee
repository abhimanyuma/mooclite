@Mooclite.module "LecturesApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Controller extends App.Controllers.Application

    initialize:(options) ->

      {course_id,lecture_id} = options


      App.redirectIfNotLoggedIn("/courses/#{course_id}/lectures/#{lecture_id}/edit")

      if App.currentUser && App.currentUser.id

        course = App.request "course:entity", App.currentUser.id.$oid, course_id

        lecture = App.request "lecture:entity", course_id, lecture_id

        @listenTo lecture, "updated", ->
          App.vent.trigger "lecture:updated", course, lecture

        @layout = @getLayoutView lecture

        @listenTo @layout, "show", =>
          @titleRegion lecture
          @formRegion  lecture, course
          @modalRegion lecture

        @show @layout,
          loading: true


    titleRegion: (lecture) ->
      titleView = @getTitleView lecture

      @show titleView,
        region: @layout.titleRegion

    formRegion: (lecture, course) ->
      editView = @getEditView lecture

      @listenTo editView, "form:cancel", ->
        App.vent.trigger "lecture:cancelled", course, lecture

      @listenTo editView, "overview:updated", =>
        @updateOverview editView

      formView = App.request "form:wrapper", editView

      @show formView,
        region: @layout.formRegion

      editView.trigger "overview:updated", lecture

    getTitleView:(lecture) ->
      new Edit.Title
        model:lecture

    getEditView: (lecture) ->
      gon.overview_length=0
      gon.overview_max=140
      new Edit.Form
        model:lecture

    getLayoutView:(lecture) ->
      new Edit.Layout
        model:lecture

    updateOverview: (view) ->
      lecture = view.model
      gon.overview_length=view.$('#overview').val().length
      remaining_length=gon.overview_max-gon.overview_length
      view.$("#overview-length").text("#{remaining_length}")

      if (remaining_length<0)
          error={"overview":["is too long (maximum is 140 characters)"]}
          if lecture.has("_errors")
            errors=lecture.get("_errors")
            if errors["overview"] is null
              errors["overview"]=error["overview"]
              lecture.unset "_errors"
              lecture.set "_errors", errors
          else
            lecture.set "_errors", error
      else
        if lecture.has("_errors")
          errors=lecture.get("_errors")
          delete errors["overview"]
          lecture.unset "_errors"