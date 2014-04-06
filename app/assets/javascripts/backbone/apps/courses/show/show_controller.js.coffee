@Mooclite.module "CoursesApp.Show", (Show, App, Backbone, Marionette, $, _ ) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
      {course,id} = options
      
      course = App.request "course:entity", id unless course

      lectures = App.request "lecture:entities", id

      @layout = @getLayoutView course

      @listenTo lectures, "change:chosen", (model,value,options) ->
        App.vent.trigger "lecture:clicked", course, model, @layout.contentRegion if value

      @listenTo @layout, "show", =>
        @titleRegion course
        @panelRegion course
        @lectureMenuRegion lectures,course
        @contentRegion course

      @show @layout,
        loading: [course,lectures]

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

    lectureMenuRegion: (lectures,course) ->
      lectureMenuView = @getLectureMenuRegion lectures

      @listenTo lectureMenuView, "course:home:clicked", =>
        App.vent.trigger "course:clicked", course

      @listenTo lectureMenuView, "childview:lecture:link:clicked" , (child,args) ->
        lecture=args.model
        lectures.choose lecture

      @show lectureMenuView,
        region: @layout.lectureMenuRegion

    getLectureMenuRegion: (lectures) ->
      new Show.LectureMenu
        collection: lectures

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
