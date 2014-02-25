@Mooclite.module "Entities", (Entities,App, Backbone, Marionette, $, _) ->

  class Entities.Course extends Entities.Model
    urlRoot: -> Routes.courses_path()

  class Entities.CoursesCollection extends Entities.Collection
    model:Entities.Course
    url: -> Routes.courses_path()

  API=
    getCoursesCollection: (cb) ->
      courses= new Entities.CoursesCollection
      courses.fetch
        success: ->
          cb courses
        "reset":true

    getCourse: (id) ->
      console.log "Requested" + id
      course = new Entities.Course
        id: id
      course.fetch()
      console.log course
      course


  App.reqres.setHandler "course:entity", (id) ->
    API.getCourse(id)

  App.reqres.setHandler "course:entities", (cb) ->
    API.getCoursesCollection cb

