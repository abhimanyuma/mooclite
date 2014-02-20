@Mooclite.module "CoursesApp.New", (New, App, Backbone, Marionette, $, _ ) ->

  New.Controller = 

    newCourse: ->
      newView = @getNewView()
      
      
      newView

    getNewView: ->
      new New.Course