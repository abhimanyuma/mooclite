@Mooclite.module "CoursesApp.List", (List,App,Backbone, Marionette,$, _) ->

  class List.Controller extends App.Controllers.Application

    initialize: ->

      App.redirectIfNotLoggedIn("/courses")

      if App.currentUser && App.currentUser.id
        courses = App.request "course:entities", App.currentUser.id.$oid

        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @showTitle()
          @showPanel()
          @showCourses courses

        @show @layout,
          loading:
            entities: courses

    onDestroy: ->

    showTitle: ->
      titleView = @getTitleView()
      @layout.titleRegion.show titleView

    showPanel: ->
      panelView = @getPanelView()

      @listenTo panelView, "new:course:button:clicked" , =>
        @showAddCourse()

      @layout.panelRegion.show panelView

    showCourses: (courses) ->
      coursesView = @getCoursesView courses

      @listenTo coursesView, "childview:course:clicked" , (child,args) ->
        App.vent.trigger "course:clicked" , args.model

      @layout.coursesRegion.show coursesView

    showAddCourse: ->
      # newCourseView = App.request "new:course:view"

      # @listenTo newCourseView, "form:cancel", =>
      #   @layout.newCourseRegion.destroy()

      # @layout.newCourseRegion.show newCourseView

      App.execute "new:course:view", @layout.newCourseRegion

    getTitleView: ->
      new List.Title

    getPanelView: ->
      new List.Panel

    getCoursesView: (courses) ->
      new List.Courses
        collection: courses

    getLayoutView: ->
      new List.Layout