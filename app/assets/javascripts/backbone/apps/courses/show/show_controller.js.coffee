@Mooclite.module "CoursesApp.Show", (Show, App, Backbone, Marionette, $, _ ) ->

  class Show.Controller extends App.Controllers.Base

    initialize: (options) ->
      {course,id} = options
      course or= App.request "course:entity", id

      App.execute "when:fetched", [course], =>
        @layout = @getLayoutView course

        @listenTo @layout, "show", =>
          @titleRegion course
          @panelRegion course
          @contentRegion course

        @show @layout

    titleRegion: (course) ->
      titleView = @getTitleView course

      @layout.titleRegion.show titleView

    contentRegion: (course) ->
      contentView = @getContentView course
      @layout.contentRegion.show contentView

    panelRegion: (course) ->
      panelView = @getPanelView course

      @listenTo panelView, "edit:course:button:clicked", =>
        App.vent.trigger "edit:course:clicked", course
      @layout.panelRegion.show panelView

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
