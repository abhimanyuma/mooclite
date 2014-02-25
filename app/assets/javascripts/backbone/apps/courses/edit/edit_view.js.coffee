@Mooclite.module "CoursesApp.Edit", (Edit, App, Backbone, Marionette, $, _ ) ->

  class Edit.Course extends App.Views.ItemView
    template: "courses/edit/templates/edit_course"

    modelEvents:
      "sync":"render"