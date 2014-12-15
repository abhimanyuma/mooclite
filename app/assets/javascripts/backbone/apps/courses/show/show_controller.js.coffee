@Mooclite.module "CoursesApp.Show", (Show, App, Backbone, Marionette, $, _ ) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
      {course,id} = options

      id ?= course.id

      App.redirectIfNotLoggedIn("/courses/#{id}")

      if App.currentUser && App.currentUser.id
        course = App.request "course:entity", App.currentUser.id.$oid, id unless course

        @layout = @getLayoutView course

        @listenTo @layout, "show", =>
          @showTitleRegion course
          @showContentRegion course
          @showLectureListRegion course

        @show @layout,
          loading:
            entities: [course]

    showTitleRegion: (course) ->
      titleView = @getTitleView course

      @layout.titleRegion.show titleView

    showContentRegion: (course) ->
      contentView = @getContentView course

      @listenTo contentView, "edit:course:button:clicked", =>
        App.vent.trigger "edit:course:clicked", course

      @layout.contentRegion.show contentView

    showLectureListRegion: (course) ->
      region = @layout.lectureListRegion
      onShow = (lectures) ->
        App.execute "list:lectures", course,lectures,region

      course.setUpLectures(onShow)

    getLayoutView: (course) ->
      new Show.Layout
        model: course

    getTitleView: (course) ->
      new Show.Title
        model: course

    getContentView: (course) ->
      new Show.Content
        model: course