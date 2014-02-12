@Mooclite.module "CoursesApp.List", (List,App,Backbone, Marionette,$, _) ->

  List.Controller = 

    list: ->
      App.request "course:entities", (courses) =>

        @layout = @getLayoutView()

        @layout.on "show", =>
          @showPanel   courses
          @showCourses courses

        App.mainRegion.show @layout

    showPanel: (courses) ->
      panelView = @getPanelView courses
      @layout.panelRegion.show panelView

    showCourses: (courses) ->
      coursesView = @getCoursesView courses
      @layout.coursesRegion.show coursesView

    getPanelView: (courses) ->
      new List.Panel
        collection: courses

    getCoursesView: (courses) ->
      new List.Courses
        collection: courses

    getLayoutView: ->
      new List.Layout