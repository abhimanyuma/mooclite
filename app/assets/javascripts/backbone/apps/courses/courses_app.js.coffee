@Mooclite.module "CoursesApp", (CoursesApp,App, Backbone, Marionette, $, _) ->

  class CoursesApp.AppRouter extends Marionette.AppRouter
    appRoutes:
      "courses" : "list"

  API = 
    list: ->
      CoursesApp.List.Controller.list()
    newCourse: ->
      CoursesApp.New.Controller.newCourse()
    edit: (member) ->
      CoursesApp.Edit.Controller.edit(member)

  App.reqres.setHandler "new:course:view", ->
    API.newCourse()

  App.vent.on "course:clicked", (member) ->
    API.edit member

  App.addInitializer ->
    new CoursesApp.AppRouter
      controller: API
