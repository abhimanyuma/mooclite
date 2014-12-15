@Mooclite.module "CoursesApp.Show", (Show, App, Backbone, Marionette, $, _ ) ->

  class Show.Layout extends App.Views.Layout
    template: "courses/show/show_layout"

    regions:
      titleRegion: "#title-region"
      contentRegion:"#content-region"
      lectureListRegion: "#lecture-list-region"

  class Show.Content extends App.Views.ItemView

    template: "courses/show/show_content"
    className: "ui segment"

    triggers:
      "click #edit-course-button": "edit:course:button:clicked"

  class Show.Title extends App.Views.ItemView
    template: "courses/show/show_title"
    className: "ui teal inverted segment"

