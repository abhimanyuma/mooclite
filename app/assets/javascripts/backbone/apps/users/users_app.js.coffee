@Mooclite.module "UsersApp", (UsersApp, App, Backbone, Marionette, $, _) ->

  class UsersApp.Router extends Marionette.AppRouter
    appRoutes:
      "users": "list"
      "users/new":"new"
      "users/:id": "show"
      "users/:id/edit": "edit"
      "signup" : "new"

    before: ->
      App.vent.trigger "nav:choose", "Users"
    
  API =
    new: ->
      new UsersApp.New.Controller

    list: ->
      new UsersApp.List.Controller

    show: ->
      new UsersApp.Show.Controller

    edit: ->
      new UsersApp.Edit.Controller

      
  App.addInitializer ->
    new UsersApp.Router
      controller: API

  App.vent.on "new:user:clicked", ->
    App.navigate Routes.new_user_path()
    API.new()