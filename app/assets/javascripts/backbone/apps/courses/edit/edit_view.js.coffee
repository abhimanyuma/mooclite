@Mooclite.module "CoursesApp.Edit", (Edit, App, Backbone, Marionette, $, _ ) ->

  class Edit.Layout extends App.Views.Layout
    template: "courses/edit/edit_layout"

    regions:
      titleRegion: "#title-region"
      formRegion:"#form-region"

  class Edit.Course extends App.Views.ItemView

    template: "courses/edit/edit_course"

  class Edit.Title extends App.Views.ItemView
    template: "courses/edit/title"

    modelEvents:
      "updated":"render"