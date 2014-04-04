@Mooclite.module "UsersApp", (UsersApp, App, Backbone, Marionette, $, _) ->

  class UsersApp.Router extends Marionette.AppRouter
    appRoutes:
      "users": "list"
      "users/:id": "show"
      "users/:id/edit": "edit"

    before: ->
      App.vent.trigger "nav:choose", "Users"
    
  API =
    list: ->
      new UsersApp.List.Controller

    show: ->
      new UsersApp.Show.Controller

    edit: ->
      new UsersApp.Edit.Controller

      
  App.addInitializer ->
    new UsersApp.Router
      controller: API
  