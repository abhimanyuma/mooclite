@Mooclite.module "CoursesApp.New", (New, App, Backbone, Marionette, $, _ ) -> 

  class New.Course extends App.Views.ItemView
    template: "courses/new/templates/new_course"
    className: "ui segment"

    triggers: 
      "click [data-form-button='cancel']":"form:cancel:button:clicked"