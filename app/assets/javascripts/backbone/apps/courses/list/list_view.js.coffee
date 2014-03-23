@Mooclite.module "CoursesApp.List", (List, App, Backbone,Marionette,$, _) ->

  class List.Layout extends App.Views.Layout
    template: "courses/list/templates/list_layout"
    regions:
      titleRegion: "#title-region"
      panelRegion: "#panel-region"
      newCourseRegion: "#new-course-region"
      coursesRegion: "#courses-region"

  class List.Title extends App.Views.ItemView
    template: "courses/list/templates/_title"
    className: "ui teal inverted segment"

  class List.Panel extends App.Views.ItemView
    template: "courses/list/templates/_panel"
    className: "ui segment"

    triggers:
      "click #new-course-button" : "new:course:button:clicked "

  class List.Empty extends App.Views.ItemView
    template: "courses/list/templates/_empty"

  class List.Course extends App.Views.ItemView

    template: "courses/list/templates/_course"
    tagName: "tr"
    className: "item" 

    triggers: 
      "click" : "course:clicked"


  class List.Courses extends App.Views.CompositeView
    template: "courses/list/templates/_courses"
    itemView: List.Course
    emptyView: List.Empty
    itemViewContainer:"tbody"

