@Mooclite.module "CoursesApp.Edit", (Edit, App, Backbone, Marionette, $, _ ) ->

  class Edit.Layout extends App.Views.Layout
    template: "courses/edit/edit_layout"

    regions:
      formRegion:"#form-region"

  class Edit.Course extends App.Views.ItemView

    template: "courses/edit/edit_course"