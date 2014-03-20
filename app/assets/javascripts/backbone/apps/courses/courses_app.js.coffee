@Mooclite.module "CoursesApp", (CoursesApp,App, Backbone, Marionette, $, _) ->

  class CoursesApp.AppRouter extends Marionette.AppRouter
    appRoutes:
      "courses/:id/edit" : "edit"
      "courses" : "list"

  API = 
    list: ->
      CoursesApp.List.Controller.list()
    newCourse: ->
      CoursesApp.New.Controller.newCourse()
    edit: (id) ->
      CoursesApp.Edit.Controller.edit(id)

  App.reqres.setHandler "new:course:view", ->
    API.newCourse()

  App.vent.on "course:clicked", (member) ->
    App.navigate Routes.edit_course_path(member.id)
    API.edit member.id

  App.vent.on "course:cancelled course:updated", (course) ->
    App.navigate Routes.courses_path()
    API.list()

  App.addInitializer ->
    new CoursesApp.AppRouter
      controller: API
