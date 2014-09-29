@Mooclite.module "Entities", (Entities,App, Backbone, Marionette, $, _) ->

  class Entities.Course extends Entities.Model
    urlRoot: -> Routes.courses_path()

  class Entities.CoursesCollection extends Entities.Collection
    model:Entities.Course
    url: -> Routes.courses_path()

  API=
    getCoursesCollection:  ->
      courses= new Entities.CoursesCollection
      courses.fetch()
      courses

    getCourse: (id) ->
      course = new Entities.Course
        id: id
      course.fetch()
      course

    newCourse: ->
      new Entities.Course


  App.reqres.setHandler "course:entity", (id) ->
    API.getCourse(id)

  App.reqres.setHandler "course:entities", ->
    API.getCoursesCollection()

  App.reqres.setHandler "new:course", ->
    API.newCourse()
