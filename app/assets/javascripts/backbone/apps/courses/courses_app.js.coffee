@Mooclite.module "CoursesApp", (CoursesApp,App, Backbone, Marionette, $, _) ->

  class CoursesApp.AppRouter extends Marionette.AppRouter
    appRoutes:
      "courses" : "list"

  API = 
    list: ->
      CoursesApp.List.Controller.listP()

  App.addInitializer ->
    new CoursesApp.AppRouter
      controller: API