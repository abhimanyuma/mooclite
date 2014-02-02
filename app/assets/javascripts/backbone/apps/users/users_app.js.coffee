@Mooclite.module "UsersApp", (UsersApp, App, Backbone, Marionette, $, _) ->

  class UsersApp.AppRouter extends Marionette.AppRouter

    appRoutes:
      "users" : "listUsers"

  API = 
    listUsers: ->
      UsersApp.List.Controller.listUsers()

  App.addInitializer ->
    new UsersApp.AppRouter
      controller: API