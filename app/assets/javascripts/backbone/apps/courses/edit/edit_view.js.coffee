@Mooclite.module "CoursesApp.Edit", (Edit, App, Backbone, Marionette, $, _ ) ->

  class Edit.Layout extends App.Views.Layout
    template: "courses/edit/edit_layout"

    regions:
      titleRegion: "#title-region"
      formRegion:"#form-region"

  class Edit.Course extends App.Views.ItemView

    template: "courses/edit/edit_course"

    triggers:
      "keyup #bio": "bio:updated" 
      

  class Edit.Title extends App.Views.ItemView
    template: "courses/edit/title"

    triggers:
      "click #delete-course": "course:delete:clicked"
    
    modelEvents:
      "updated":"render"


    