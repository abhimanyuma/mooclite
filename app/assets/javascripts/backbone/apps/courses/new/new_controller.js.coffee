@Mooclite.module "CoursesApp.New", (New, App, Backbone, Marionette, $, _ ) ->

  class New.Controller extends App.Controllers.Application

    initialize: ->
      if App.currentUser && App.currentUser.id
        course = App.request "new:course" , App.currentUser.id.$oid

        @listenTo course, "created", ->
          App.vent.trigger "course:created", course


        newView = @getNewView course

        formView = App.request "form:wrapper", newView

        @listenTo newView, "form:cancel", ->
          @region.reset()

        @show formView



    getNewView: (course) ->
      new New.Course
        model: course