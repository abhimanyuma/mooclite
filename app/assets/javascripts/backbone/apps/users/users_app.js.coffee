@Mooclite.module "UsersApp", (UsersApp, App, Backbone, Marionette, $, _) ->

  class UsersApp.AppRouter extends Marionette.AppRouter

    appRoutes:
      "users" : "list"

  API = 
    list: ->
      UsersApp.List.Controller.list()

  App.addInitializer ->
    new UsersApp.AppRouter
      controller: API