@Mooclite.module "CoursesApp.Edit", (Edit, App, Backbone, Marionette, $, _ ) ->

  Edit.Controller = 

    edit: (course) ->
      editView = @getEditView course
      App.mainRegion.show editView

    getEditView: (course) -> 
      new Edit.Course
        model:course