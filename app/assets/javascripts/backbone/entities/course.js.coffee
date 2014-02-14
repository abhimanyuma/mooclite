@Mooclite.module "Entities", (Entities,App, Backbone, Marionette, $, _) ->

  class Entities.Course extends Entities.Model

  class Entities.CoursesCollection extends Entities.Collection
    model:Entities.Course
    url: -> Routes.courses_path()

  API=
    getCourseEntities: (cb) ->
      courses= new Entities.CoursesCollection
      courses.fetch
        success: ->
          cb courses
        "reset":true


  App.reqres.setHandler "course:entities", (cb) ->
    API.getCourseEntities cb

