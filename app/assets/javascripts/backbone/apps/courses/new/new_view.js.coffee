@Mooclite.module "CoursesApp.New", (New, App, Backbone, Marionette, $, _ ) -> 

  class New.Course extends App.Views.ItemView
    template: "courses/new/templates/new_course"