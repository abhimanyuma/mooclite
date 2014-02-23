@Mooclite.module "CoursesApp.Edit", (Edit, App, Backbone, Marionette, $, _ ) ->

  Edit.Controller = 

    edit: (id, course) ->
      course or= App.request "course:entity", id
      editView = @getEditView course
      App.mainRegion.show editView

    getEditView: (course) -> 
      new Edit.Course
        model:course