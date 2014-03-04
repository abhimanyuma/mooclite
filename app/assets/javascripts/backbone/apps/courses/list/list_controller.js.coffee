@Mooclite.module "CoursesApp.List", (List,App,Backbone, Marionette,$, _) ->

  List.Controller = 

    list: ->
      courses = App.request "course:entities"
      App.execute "when:fetched", courses, =>
        
        @layout = @getLayoutView()

        @layout.on "show", =>
          @showTitle()
          @showPanel()
          @showCourses courses

        App.mainRegion.show @layout

    showTitle: ->
      titleView = @getTitleView()
      @layout.titleRegion.show titleView

    showPanel: ->
      panelView = @getPanelView()

      panelView.on "new:course:button:clicked" , =>
        @showAddCourse()

      @layout.panelRegion.show panelView

    showCourses: (courses) ->
      coursesView = @getCoursesView courses

      coursesView.on "childview:course:clicked" , (child,member) ->
        App.vent.trigger "course:clicked" , member

      @layout.coursesRegion.show coursesView

    showAddCourse: ->
      newCourseView = App.request "new:course:view"

      newCourseView.on "form:cancel:button:clicked", =>
        @layout.newCourseRegion.close()
        
      @layout.newCourseRegion.show newCourseView

    getTitleView: ->
      new List.Title

    getPanelView: ->
      new List.Panel

    getCoursesView: (courses) ->
      new List.Courses
        collection: courses

    getLayoutView: ->
      new List.Layout