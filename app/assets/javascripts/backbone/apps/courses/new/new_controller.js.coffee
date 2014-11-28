@Mooclite.module "CoursesApp.New", (New, App, Backbone, Marionette, $, _ ) ->

  class New.Controller extends App.Controllers.Application 

    initialize: ->
      course = App.request "new:course"
      
      @listenTo course, "created", ->
        App.vent.trigger "course:created", course


      newView = @getNewView course
      
      formView = App.request "form:wrapper", newView

      @listenTo newView, "form:cancel", ->
        @region.destroy()

      @show formView



    getNewView: (course) ->
      new New.Course
        model: course