@Mooclite.module "LecturesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
     
      {course_id,lecture_id} = options

      course = App.request "course:entity", course_id

      console.log "Test"
      lecture = App.request "lecture:entity", course_id, lecture_id

      @layout = @getLayoutView lecture

      @listenTo @layout, "show", =>
        @titleRegion lecture
        @contentRegion lecture

      @show @layout,
        loading: true

    titleRegion: (lecture) ->
      titleView = @getTitleView lecture

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