@Mooclite.module "CoursesApp.Show", (Show, App, Backbone, Marionette, $, _ ) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
      {course,id,lecture_id} = options
      
      course = App.request "course:entity", id unless course

      lectures = App.request("lecture:entities",id)

      @layout = @getLayoutView course

      @listenTo lectures, "change:chosen", (model,value,options) ->
        App.vent.trigger "lecture:clicked", course, model, @layout.contentLayout if value

      @listenTo @layout, "show", =>
        @titleRegion course
        @lectureMenuRegion lectures,course
        @contentLayout course
        @setLecture lectures,lecture_id

      @show @layout,
        loading: 
          entities: [course,lectures]

    setLecture: (collection,id) ->
      collection.chooseByNo(parseInt(id))

    titleRegion: (course) ->
      titleView = @getTitleView course

      @show titleView,
        region: @layout.titleRegion

    contentLayout: (course) ->
      @contentLayout = @getContentLayout course

      @listenTo @contentLayout, "show", =>
        @panelRegion course
        @contentRegion course

      @show @contentLayout,
        region: @layout.contentLayout

    contentRegion: (course) ->
      contentView = @getContentView course

      @show contentView,
        region: @contentLayout.contentRegion

    panelRegion: (course) ->
      panelView = @getPanelView course

      @listenTo panelView, "edit:course:button:clicked", =>
        App.vent.trigger "edit:course:clicked", course

      @show panelView,
        region: @contentLayout.panelRegion

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

    getContentLayout: (course) ->
      new Show.ContentLayout
        model:course

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
