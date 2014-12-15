@Mooclite.module "LecturesApp.List", (List, App, Backbone, Marionette, $, _ ) ->

  class List.Empty extends App.Views.ItemView
    template: "lectures/list/_empty"

  class List.Lecture extends App.Views.ItemView

    template: "lectures/list/_lecture"
    tagName: "tr"
    className: "item"

    triggers:
      "click" : "lecture:clicked"


  class List.Lectures extends App.Views.CompositeView
    template: "lectures/list/_lectures"
    childView: List.Lecture
    emptyView: List.Empty
    childViewContainer:"tbody"