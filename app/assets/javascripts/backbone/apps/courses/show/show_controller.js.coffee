@Mooclite.module "CoursesApp.Show", (Show, App, Backbone, Marionette, $, _ ) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
      {course,id} = options
      
      course = App.request "course:entity", id unless course

      @layout = @getLayoutView course

      @listenTo @layout, "show", =>
        @titleRegion course
        @panelRegion course
        @contentRegion course

      @show @layout,
        loading:true

    titleRegion: (course) ->
      titleView = @getTitleView course

      @show titleView,
        region: @layout.titleRegion

    contentRegion: (course) ->
      contentView = @getContentView course

      @show contentView,
        region: @layout.contentRegion

    panelRegion: (course) ->
      panelView = @getPanelView course

      @listenTo panelView, "edit:course:button:clicked", =>
        App.vent.trigger "edit:course:clicked", course

      @show panelView,
        region: @layout.panelRegion

    getLayoutView: (course) ->
      new Show.Layout
        model: course

    getTitleView: (course) ->
      new Show.Title
        model: course

    getContentView: (course) ->
      new Show.Content
        model: course

    getPanelView: (course) ->
      new Show.Panel
        model: course
