@Mooclite.module "CoursesApp.List", (List, App, Backbone,Marionette,$, _) ->

  class List.Layout extends App.Views.Layout
    template: "courses/list/templates/list_layout"
    regions:
      panelRegion: "#panel-region"
      coursesRegion: "#courses-region"

  class List.Panel extends App.Views.ItemView
    template: "courses/list/templates/_panel"

  class List.Empty extends App.Views.ItemView

    template: "courses/list/templates/_empty"

  class List.Course extends App.Views.ItemView

    template: "courses/list/templates/_course"
    tagName: "tr"
    className: "item" 


  class List.Courses extends App.Views.CompositeView
    template: "courses/list/templates/_courses"
    itemView: List.Course
    emptyView: List.Empty
    itemViewContainer:"tbody"

