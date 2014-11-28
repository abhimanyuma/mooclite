@Mooclite.module "CoursesApp.Show", (Show, App, Backbone, Marionette, $, _ ) ->

  class Show.Layout extends App.Views.Layout
    template: "courses/show/show_layout"

    regions:
      titleRegion: "#title-region"
      contentLayout:"#content-layout-region"
      lectureMenuRegion: "#menu-region"

  class Show.ContentLayout extends App.Views.Layout

    template: "courses/show/content_layout"

    regions:
      panelRegion: "#panel-region"
      contentRegion: "#content-region"

  class Show.Content extends App.Views.ItemView

    template: "courses/show/show_content"
    className: "ui segment"

  class Show.Panel extends App.Views.ItemView
    template: "courses/show/_panel"
    className: "ui segment"

    triggers:
      "click #edit-course-button" : "edit:course:button:clicked"


  class Show.Title extends App.Views.ItemView
    template: "courses/show/show_title"
    className: "ui teal inverted segment"

  class Show.Lecture extends App.Views.ItemView
    template: "courses/show/list_lecture"
    tagName: "a"
    className: "item"
    attributes: {"href": "#"}

    triggers:
      "click" : "lecture:link:clicked"


    modelEvents:
      "change:chosen" :  "changeChosen"

    changeChosen: (model,value,options) ->
      @$el.toggleClass "active", value

  class Show.LectureMenu extends App.Views.CompositeView
    template: "courses/show/list_lectures"
    #className: "ui vertical pointing secondary menu"
    childView: Show.Lecture
    childViewContainer: "div#menu-list"

    triggers:
      "click #home" : "course:home:clicked"
      "click .new-lecture" : "new:lecture:clicked"

