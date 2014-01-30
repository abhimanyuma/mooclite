@Mooclite.module "UsersApp", (UsersApp, App, Backbone, Marionette, $, _) ->

  class UsersApp.AppRouter extends Marionette.AppRouter

    appRoutes:
      "users" : "listUsers"

  API = 
    listUsers: ->
      console.log "List Users Called"

  App.addInitializer ->
    new UsersApp.AppRouter
      controller: API