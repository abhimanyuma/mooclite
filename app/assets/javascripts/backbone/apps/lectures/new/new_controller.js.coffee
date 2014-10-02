@Mooclite.module "LecturesApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Application

    initialize:(options) ->

      {course_id} = options

      course = App.request "course:entity", course_id

      lecture = App.request "new:lecture:entity", course_id

      @layout = @getLayoutView lecture

      @listenTo @layout, "show", =>
        @titleRegion lecture, course
        @formRegion  lecture, course

      @show @layout,
        loading: true


    titleRegion: (lecture, course) ->
      titleView = @getTitleView lecture,course

      @show titleView,
        region: @layout.titleRegion

    formRegion: (lecture, course) ->
      editView = @getEditView lecture

      @listenTo editView, "form:cancel", ->
        App.vent.trigger "lecture:cancelled", course, lecture, @region

      @listenTo editView, "overview:updated", =>
        @updateOverview editView

      formView = App.request "form:wrapper", editView

      @show formView,
        region: @layout.formRegion

      editView.trigger "overview:updated", lecture

    getTitleView:(lecture,course) ->
      new New.Title
        model:lecture
        course:course

    getEditView: (lecture) ->
      gon.overview_length=0
      gon.overview_max=140
      new New.Form
        model:lecture

    getLayoutView:(lecture) ->
      new New.Layout
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