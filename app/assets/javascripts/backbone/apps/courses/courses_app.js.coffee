@Mooclite.module "CoursesApp", (CoursesApp,App, Backbone, Marionette, $, _) ->

  class CoursesApp.AppRouter extends Marionette.AppRouter
    appRoutes:
      "courses" : "listCourses"

  API = 
    listCourses: ->
      CoursesApp.List.Controller.listCourses()

  App.addInitializer ->
    new CoursesApp.AppRouter
      controller: API