@Mooclite.module "LecturesApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->

      {course_id,lecture_id} = options

      App.redirectIfNotLoggedIn("/courses/#{course_id}/lectures/#{lecture_id}")

      if App.currentUser && App.currentUser.id

        course = App.request "course:entity", App.currentUser.id.$oid, course_id
        lecture = App.request "lecture:entity", course_id, lecture_id

        @layout = @getLayoutView lecture

        @listenTo @layout, "show", =>
          @titleRegion course, lecture
          @contentRegion lecture

        @show @layout,
          loading:
            entities: [course,lecture]

    titleRegion: (course, lecture) ->
      titleView = @getTitleView lecture

      @listenTo titleView, "edit:lecture:button:clicked", ->
        App.vent.trigger "lecture:edit:clicked", course, lecture

      @listenTo titleView, "update:files:lecture:button:clicked", ->
        App.vent.trigger "lecture:update:files:clicked", course, lecture

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