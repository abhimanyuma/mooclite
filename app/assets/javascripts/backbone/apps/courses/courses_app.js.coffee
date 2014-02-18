@Mooclite.module "CoursesApp", (CoursesApp,App, Backbone, Marionette, $, _) ->

  class CoursesApp.AppRouter extends Marionette.AppRouter
    appRoutes:
      "courses" : "list"

  API = 
    list: ->
      CoursesApp.list.Controller.list()
    newCourse: ->
      CoursesApp.new.Contorller.newCourse() 

  App.reqres.setHandler "new:course:view", ->
    API.newCourse()

  App.addInitializer ->
    new CoursesApp.AppRouter
      controller: API
