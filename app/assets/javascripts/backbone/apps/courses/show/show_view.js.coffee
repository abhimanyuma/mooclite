@Mooclite.module "CoursesApp.Show", (Show, App, Backbone, Marionette, $, _ ) ->

  class Show.Layout extends App.Views.Layout
    template: "courses/show/show_layout"

    regions:
      titleRegion: "#title-region"
      panelRegion: "#panel-region"
      contentRegion:"#content-region"
      lectureMenuRegion: "#menu-region"

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

  class Show.LectureMenu extends App.Views.CompositeView
    template: "courses/show/list_lectures"
    className: "ui vertical pointing secondary menu"
    itemView: Show.Lecture
    itemViewContainer: "div"

