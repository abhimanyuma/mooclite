@Mooclite.module "CoursesApp.New", (New, App, Backbone, Marionette, $, _ ) ->

  New.Controller = 

    newCourse: ->
      course = App.request "new:course"
      
      course.on "created", ->
        App.vent.trigger "course:created", course

      newView = @getNewView course
      

      App.request "form:wrapper", newView

    getNewView: (course) ->
      new New.Course
        model: course