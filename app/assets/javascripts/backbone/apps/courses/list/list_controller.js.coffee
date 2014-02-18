@Mooclite.module "CoursesApp.List", (List,App,Backbone, Marionette,$, _) ->

  List.Controller = 

    list: ->
      App.request "course:entities", (courses) =>

        @layout = @getLayoutView()

        @layout.on "show", =>
          @showPanel()
          @showAddCourse()
          @showCourses courses

        App.mainRegion.show @layout

    showPanel: ->
      panelView = @getPanelView()
      @layout.panelRegion.show panelView

    showCourses: (courses) ->
      coursesView = @getCoursesView courses
      @layout.coursesRegion.show coursesView

    showAddCourse: ->
      newCourseView = App.request "new:course:view"
      @layout.newCourseRegion.show newCourseView

    getPanelView: ->
      new List.Panel

    getCoursesView: (courses) ->
      new List.Courses
        collection: courses

    getLayoutView: ->
      new List.Layout