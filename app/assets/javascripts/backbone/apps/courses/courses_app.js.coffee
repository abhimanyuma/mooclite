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
    edit: (id, course) ->
      CoursesApp.Edit.Controller.edit(id,course)

  App.reqres.setHandler "new:course:view", ->
    API.newCourse()

  App.vent.on "course:clicked", (member) ->
    App.navigate Routes.edit_course_path(member.id)
    API.edit member.id, member

  App.addInitializer ->
    new CoursesApp.AppRouter
      controller: API
