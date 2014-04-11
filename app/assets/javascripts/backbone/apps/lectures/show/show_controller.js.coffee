@Mooclite.module "LecturesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
     
      {course_id,lecture_id} = options

      course = App.request "course:entity", course_id

      lecture = App.request "lecture:entity", course_id, lecture_id

      @layout = @getLayoutView lecture

      @listenTo @layout, "show", =>
        @titleRegion course, lecture
        @contentRegion lecture

      @show @layout,
        loading: true

    titleRegion: (course, lecture) ->
      titleView = @getTitleView lecture

      @listenTo titleView, "edit:lecture:button:clicked", ->
        console.log "Edit lecture button clicked"
        App.vent.trigger "lecture:edit:clicked", course, lecture, @region

      @show titleView,
        region: @layout.titleRegion

    contentRegion: (lecture) ->
      contentView = @getContentView lecture

      @show contentView,
        region: @layout.contentRegion

    getTitleView:(lecture) ->
      new Show.Title 
        model:lecture

    getContentView: (lecture) ->
      new Show.Content
        model:lecture

    getLayoutView:(lecture) ->
      new Show.Layout
        model:lecture